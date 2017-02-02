package com.marsspiders.ukwa.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Date;
import java.util.Map;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Map<String, Object> model) {
        model.put("time", new Date());

        return "home";
    }
}
