package com.marsspiders.ukwa.controllers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;

@Controller
public class CustomErrorController implements ErrorController {
    private static final Log log = LogFactory.getLog(CustomErrorController.class);

    private static final String PATH_ERROR = "/error";

    @RequestMapping(value = PATH_ERROR)
    public ModelAndView defaultErrorHandler(HttpServletResponse res) throws Exception {
        if(res.getStatus() == 404){
            return  new ModelAndView("error404");
        }

        return  new ModelAndView("error500");
    }

    @Override
    public String getErrorPath() {
        return PATH_ERROR;
    }
}
