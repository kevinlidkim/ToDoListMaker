package com.blurple.controller;

import com.blurple.models.ToDoList;
import com.blurple.models.ListItem;

import java.util.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import org.json.*;
import org.json.JSONException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class ToDoListMakerController {
	String message = "Welcome to ToDoList Maker! ";

	@RequestMapping("/")
	public ModelAndView landingPage() {
		return new ModelAndView("index");
	}

	@RequestMapping("/tdlm")
	public ModelAndView showMessage(
			@RequestParam(value = "user", required = false) String user,
			@RequestParam(value = "email", required = false) String email) {
		if (user == null && email == null) {
			return landingPage();
		}
		else {
			ModelAndView mv = new ModelAndView("tdlm");
			mv.addObject("user", user);
			mv.addObject("email", email);
			// Send viewable list so load dialog shows the list right away
			List<ToDoList> allLists = ObjectifyService.ofy().load().type(ToDoList.class).list();

			// only get the lists that are public or by owner
			List<ToDoList> viewableLists = new ArrayList<ToDoList>();
			ToDoList selectedList = new ToDoList();

			for (ToDoList list : allLists) {
				System.out.println(email);
				System.out.println(list.getOwner());
				if (list.isPublic()) {
					System.out.println(list.getName());
					viewableLists.add(list);
				} else if (list.getOwner().equals(email)) {
					viewableLists.add(list);
					System.out.println("should be here");
				}
				System.out.println("------");
			}

			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

			// Turn it to json object before sending to frontEnd
			String viewableLists_json = gson.toJson(viewableLists);
			String selectedList_json = gson.toJson(selectedList);
			mv.addObject("viewableLists", viewableLists_json);
			mv.addObject("selectedList", selectedList_json);
			mv.addObject("isPublic", selectedList.isPublic());
			return mv;
		}
	}

	@RequestMapping("/createList")
	public ModelAndView createList(@RequestBody String input) throws Exception {

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		// parse the request and get the fields
		JSONObject request = new JSONObject(input);
		JSONArray jArr = request.getJSONArray("list");
		String listName = request.getString("name");
		boolean isPublic = "true".equals(request.getString("isPublic"));
		String owner = request.getString("owner");


		// check to see if we are using a currenty loaded list. if so, delete list to avoid duplicates
		String currentList = request.getString("listId");
		System.out.println(currentList);
		System.out.println(listName);
//		if (!currentList.equals("")) {
//
//			Long currentListId = Long.parseLong(request.getString("listId"));
//			// get the list of items and delete them all
//			List<ListItem> listOfItems = ObjectifyService.ofy().load().type(ToDoList.class).id(currentListId).now().getList();
//			for (ListItem items : listOfItems) {
//				ObjectifyService.ofy().delete().type(ListItem.class).id(items.getId()).now();
//			}
//			//ObjectifyService.ofy().delete().type(ToDoList.class).id(currentListId).now();
//		}

		ToDoList toDoList;

		// build the list
		if (currentList.equals("")) {
			System.out.println(isPublic);
			toDoList = new ToDoList(listName, isPublic, owner);
		} else {
			Long currentListId = Long.parseLong(request.getString("listId"));
			toDoList = ObjectifyService.ofy().load().type(ToDoList.class).id(currentListId).now();
			List<ListItem> listOfItems = toDoList.getList();
			for (ListItem items : listOfItems) {
				//System.out.println("hi");
//				toDoList.removeItem(items);
				ObjectifyService.ofy().delete().type(ListItem.class).id(items.getId()).now();
			}
			toDoList.removeAll();

			toDoList.setName(listName);
			if (isPublic) {
				toDoList.setPublic();
			} else {
				toDoList.setPrivate();
			}
		}



		for (int i = 0; i < jArr.length(); i++) {
			// build a list item for each item in the list
			JSONObject jObj = jArr.getJSONObject(i);
			String category = jObj.getString("category");
			String description = jObj.getString("description");
			Date startDate = df.parse(jObj.getString("startDate"));
			Date endDate = df.parse(jObj.getString("endDate"));
			boolean completed = "true".equals(jObj.getString("completed"));
			ListItem listItem = new ListItem(null, category, description, startDate, endDate, completed);
			toDoList.addItem(listItem);
			ObjectifyService.ofy().save().entity(listItem).now();
			System.out.println("we are adding " + category);
		}

		// save to datastore
		ObjectifyService.ofy().save().entity(toDoList).now();

		ModelAndView mv = new ModelAndView("tdlm");
		//add todoList.getId to frontend so we know current list to edit
		mv.addObject("currentListId", toDoList.getId());
		return mv;
	}

	@RequestMapping("/loadViewableLists")
	public ModelAndView loadViewableLists(
			@RequestParam(value = "email") String email) {

		String ownerEmail = email;

		List<ToDoList> allLists = ObjectifyService.ofy().load().type(ToDoList.class).list();
		ToDoList selectedList = new ToDoList();

		// only get the lists that are public or by owner
		List<ToDoList> viewableLists = new ArrayList<ToDoList>();


		for (ToDoList list : allLists) {
			System.out.println(ownerEmail);
			System.out.println(list.getOwner());
			if (list.isPublic()) {
				viewableLists.add(list);
			} else if (list.getOwner().equals(ownerEmail)) {
				viewableLists.add(list);
				System.out.println("should be here");
			}
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

		// Turn it to json object before sending to frontEnd
		String selectedList_json = gson.toJson(selectedList);
		String viewableLists_json = gson.toJson(viewableLists);

		ModelAndView mv = new ModelAndView("tdlm");
		mv.addObject("viewableLists", viewableLists_json);
		mv.addObject("selectedList", selectedList_json);
		return mv;
	}

	@RequestMapping("/loadSelectedList")
	public ModelAndView loadSelectedList(
			@RequestParam(value = "id") String id,
			@RequestParam(value = "email") String email) {
		// edit this. it should take in the selected list id as a parameter from frontend AND email
		String idString = id;

		/* need to retrieve id as a string because it is too long to be an integer. */
		//String idString = "4644337115725824";
		Long listId = Long.parseLong(idString);
		//String ownerEmail = "kev";
		String ownerEmail = email;

		ToDoList selectedList = ObjectifyService.ofy().load().type(ToDoList.class).id(listId).now();
		System.out.println(listId);
		System.out.println(email);
		System.out.println(selectedList);
		ModelAndView mv = new ModelAndView("tdlm");
		// get all viewable lists again
		List<ToDoList> allLists = ObjectifyService.ofy().load().type(ToDoList.class).list();

		// only get the lists that are public or by owner
		List<ToDoList> viewableLists = new ArrayList<ToDoList>();

		for (ToDoList list : allLists) {
			if (list.isPublic()) {
				viewableLists.add(list);
			} else if (list.getOwner().equals(ownerEmail)) {
				viewableLists.add(list);
			}
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

		// Turn it to json object before sending to frontEnd
		String selectedList_json = gson.toJson(selectedList);
		String viewableLists_json = gson.toJson(viewableLists);

		mv.addObject("selectedList", selectedList_json);
		mv.addObject("viewableLists", viewableLists_json);
		mv.addObject("currentListName", selectedList.getName());
		mv.addObject("currentListId", selectedList.getId());
		mv.addObject("isPublic", selectedList.isPublic());

		return mv;

	}

}
