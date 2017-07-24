package com.marsspiders.ukwa.controllers;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.Map;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
public class HomeController {
    public static final String PROJECT_NAME = "ukwa";

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = {"", "/", "/{lang}/", PROJECT_NAME}, method = GET)
    public String homePageMapping(Map<String, Object> model, @PathVariable(value = "lang", required = false) String lang) {
        model.put("time", new Date());
        model.put("setProtocolToHttps", setProtocolToHttps);

        return "index";
    }

    @RequestMapping(value = "ukwa/{pageName}", method = GET)
    public ModelAndView temporaryDefaultNamesPageMapping(@PathVariable("pageName") String pageName) {
        ModelAndView modelAndView = new ModelAndView(pageName);
        modelAndView.addObject("setProtocolToHttps", setProtocolToHttps);

        return modelAndView;
    }

    @RequestMapping(value = "ukwa/info/{pageName:about|nominate|faq|contact|terms_conditions|privacy|notice_takedown|search_tips|cookies}", method = GET)
    public ModelAndView staticInfoPageMapping(@PathVariable("pageName") String pageName) {
        ModelAndView modelAndView = new ModelAndView(pageName);
        modelAndView.addObject("setProtocolToHttps", setProtocolToHttps);

        return modelAndView;
    }

    /*@RequestMapping(value = "ukwa/advancedsearch", method = GET)
    public ModelAndView advancedSearchPageMapping() {
        ModelAndView modelAndView = new ModelAndView("advanced");
        modelAndView.addObject("setProtocolToHttps", setProtocolToHttps);

        return modelAndView;
    }*/

    @RequestMapping(value = "ukwa/version", method = GET)
    public ModelAndView versionPageMapping() {
        ModelAndView modelAndView = new ModelAndView("version");
        modelAndView.addObject("setProtocolToHttps", setProtocolToHttps);

        return modelAndView;
    }
}
