package com.marsspiders.ukwa.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.Map;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
public class HomeController {
    static final String PROJECT_NAME = "ukwa";

    @RequestMapping(value = {"", "/", PROJECT_NAME}, method = GET)
    public String home(Map<String, Object> model) {
        model.put("time", new Date());

        return "index";
    }

    @RequestMapping(value = "ukwa/{pageName}", method = GET)
    public ModelAndView temporaryPageMapping(@PathVariable("pageName") String pageName) {

        return new ModelAndView(pageName);
    }

    @RequestMapping(value = "ukwa/info/{pageName:about|mementos|nominate|faq|technical|contact}", method = GET)
    public ModelAndView staticInfoPageMapping(@PathVariable("pageName") String pageName) {
        return new ModelAndView(pageName);
    }
}
