package com.blurple.controller;

import com.blurple.models.ToDoList;
import com.blurple.models.ListItem;

import java.util.*;
import org.json.*;
import org.json.JSONException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ToDoListMakerController {
	String message = "Welcome to Springaaa MVC!";

	@RequestMapping("/")
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
	public ModelAndView createList(@RequestBody String input) throws JSONException {

		// parse the request and get the fields
		JSONObject request = new JSONObject(input);
		JSONArray jArr = request.getJSONArray("list");
		String listName = request.getString("name");

		for (int i = 0; i < jArr.length(); i++) {
			JSONObject jObj = jArr.getJSONObject(i);
			// build a list item for each item in the list
		}

		// build the actual list here

		ModelAndView mv = new ModelAndView("newpage");
		return mv;
	}

	// @RequestMapping("/createList")
	// public void createList(@RequestParam(value = "currentListData[]") String currentListData) {
	// 	System.out.println("the list");
	// 	System.out.println(currentListData);
	// 	System.out.println("create");
	// }
}
