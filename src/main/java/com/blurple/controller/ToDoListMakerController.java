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

@Controller
public class ToDoListMakerController {
	String message = "Welcome to Springaaa MVC!";

	@RequestMapping("/")
	public ModelAndView landingPage() {
		return new ModelAndView("index");
	}

	@RequestMapping("/tdlm")
	public ModelAndView showMessage(
			@RequestParam(value = "name", required = false, defaultValue = "World") String name) {

		ModelAndView mv = new ModelAndView("tdlm");
		mv.addObject("message", message);
		mv.addObject("name", name);
		return mv;
	}

	@RequestMapping("/new")
	public ModelAndView newPageAdded() {

		ModelAndView mv = new ModelAndView("newpage");
		mv.addObject("message", "DUHH");
		mv.addObject("name", "YOOOO");
		return mv;
	}

	@RequestMapping("/createList")
	public ModelAndView createList(@RequestBody String input) throws Exception {

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		// parse the request and get the fields
		JSONObject request = new JSONObject(input);
		JSONArray jArr = request.getJSONArray("list");
		String listName = request.getString("name");
		boolean isPublic = "True".equals(request.getString("isPublic"));
		String owner = request.getString("owner");

		// build the list
		ToDoList toDoList = new ToDoList(listName, isPublic, owner);

		for (int i = 0; i < jArr.length(); i++) {
			// build a list item for each item in the list
			JSONObject jObj = jArr.getJSONObject(i);
			String category = jObj.getString("category");
			String description = jObj.getString("description");
			Date startDate = df.parse(jObj.getString("startDate"));
			Date endDate = df.parse(jObj.getString("endDate"));
			boolean completed = "True".equals(jObj.getString("completed"));
			ListItem listItem = new ListItem(null, category, description, startDate, endDate, completed);
			toDoList.addItem(listItem);
			ObjectifyService.ofy().save().entity(listItem).now();
		}

		// save to datastore
		ObjectifyService.ofy().save().entity(toDoList).now();

		ModelAndView mv = new ModelAndView("newpage");
		return mv;
	}

	@RequestMapping("/loadViewableLists")
	public ModelAndView loadViewableLists() {

		System.out.println("LOADING IN BACKEND");

		String ownerEmail = "kev";

		// filters not working... why???

		// List<ToDoList> publicLists = ObjectifyService.ofy().load().type(ToDoList.class).filter("isPublic ==", true).list();
		// List<ToDoList> ownerLists = ObjectifyService.ofy().load().type(ToDoList.class).filter("owner ==", ownerEmail).list();

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

		ModelAndView mv = new ModelAndView("newpage");
		mv.addObject("viewableLists", viewableLists);
		return mv;
	}
}
