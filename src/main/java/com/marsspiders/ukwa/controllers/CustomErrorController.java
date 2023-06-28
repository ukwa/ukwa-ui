package com.marsspiders.ukwa.controllers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@Controller
public class CustomErrorController implements ErrorController {
    private static final String PATH_ERROR = "/error";

    private static final Log log = LogFactory.getLog(CustomErrorController.class);

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = PATH_ERROR)
    public ModelAndView defaultErrorHandler(HttpServletRequest req, HttpServletResponse res) throws Exception {

        log.error("Handling Error Response: " + res);
        Exception e = (Exception) req.getAttribute(RequestDispatcher.ERROR_EXCEPTION);
        log.error("Underlying Exception: ", e);

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
