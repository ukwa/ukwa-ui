package com.marsspiders.ukwa.controllers;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;

@Controller
public class CustomErrorController implements ErrorController {
    private static final String PATH_ERROR = "/error";

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = PATH_ERROR)
    public ModelAndView defaultErrorHandler(HttpServletResponse res) throws Exception {
        String errorPageView;
        if(res.getStatus() == 404){
            errorPageView = "error404";
        }else {
            errorPageView = "error500";
        }

        ModelAndView modelAndView = new ModelAndView(errorPageView);
        modelAndView.addObject("setProtocolToHttps", setProtocolToHttps);

        return modelAndView;
    }

    @Override
    public String getErrorPath() {
        return PATH_ERROR;
    }
}
