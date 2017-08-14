package com.marsspiders.ukwa.controllers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.ErrorAttributes;
import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

import static org.apache.commons.lang3.StringUtils.isBlank;

@Controller
public class CustomErrorController implements ErrorController {
    private static final Log log = LogFactory.getLog(CustomErrorController.class);

    private static final String PATH_ERROR = "/error";

    @Autowired
    private ErrorAttributes errorAttributes;

    @RequestMapping(value = PATH_ERROR)
    public ModelAndView defaultErrorHandler(HttpServletRequest req, HttpServletResponse res, Exception e) throws Exception {
        Map<String, Object> errorAttributes = getErrorAttributes(req, true);
        String attributeError = (String) errorAttributes.get("error");
        String attributeMessage = (String) errorAttributes.get("message");
        String attributeTimeStamp = errorAttributes.get("timestamp").toString();
        String attributeTrace = (String) errorAttributes.get("trace");

        boolean pageNotFound = res.getStatus() == 404;

        ModelAndView mav = new ModelAndView("errorpage");
        mav.addObject("attributeError", toHtmlText(attributeError));
        mav.addObject("attributeMessage", toHtmlText(attributeMessage));
        mav.addObject("attributeTrace", toHtmlText(attributeTrace));
        mav.addObject("attributeTimeStamp", attributeTimeStamp);
        mav.addObject("pageNotFound", pageNotFound);

        return mav;
    }

    private String toHtmlText(String attributeError) {
        if(isBlank(attributeError)){
            return "";
        }

        return attributeError.replaceAll("\n", "<br/>").replaceAll("\t", "&emsp;");
    }

    @Override
    public String getErrorPath() {
        return PATH_ERROR;
    }

    private Map<String, Object> getErrorAttributes(HttpServletRequest request, boolean includeStackTrace) {
        RequestAttributes requestAttributes = new ServletRequestAttributes(request);

        return errorAttributes.getErrorAttributes(requestAttributes, includeStackTrace);
    }
}
