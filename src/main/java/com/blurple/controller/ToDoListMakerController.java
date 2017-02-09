package com.blurple.controller;
 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ToDoListMakerController {
	String message = "Welcome to Springaaa MVC!";
 
	@RequestMapping("/")
	public ModelAndView showMessage(
			@RequestParam(value = "name", required = false, defaultValue = "World") String name) {
 
		ModelAndView mv = new ModelAndView("helloworld");
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
}