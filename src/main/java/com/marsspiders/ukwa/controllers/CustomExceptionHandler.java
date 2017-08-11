package com.marsspiders.ukwa.controllers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class CustomExceptionHandler {
    private static final Log log = LogFactory.getLog(CustomExceptionHandler.class);

    @ExceptionHandler(value = Exception.class)
    public ModelAndView defaultErrorHandler(HttpServletRequest req, Exception e) throws Exception {
        log.error("Failed to handle request at URL: " + req.getRequestURL(), e);

        ModelAndView mav = new ModelAndView();
        mav.addObject("errorText", e.getMessage());
        mav.setViewName("errorpage");

        return mav;
    }
}
