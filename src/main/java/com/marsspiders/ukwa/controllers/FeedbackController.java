package com.marsspiders.ukwa.controllers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.text.ParseException;

import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;

@Controller
@RequestMapping(value = PROJECT_NAME)
public class FeedbackController {
    private static final Log log = LogFactory.getLog(FeedbackController.class);

    @Value("${bl.send.mail.to}")
    private String sendMailTo;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @Autowired
    public JavaMailSender emailSender;

    @RequestMapping(value = "contact", method = RequestMethod.POST)
    public ModelAndView sendFeedback(@RequestParam(value = "name", required = false) String name,
                                     @RequestParam(value = "email", required = false) String email,
                                     @RequestParam(value = "comments", required = false) String comments) {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(sendMailTo);
        message.setSubject("Contact form request [" + name + "]");
        message.setText("Request from: " + name + "\n"
                + "Contact e-mail: " + email + "\n"
                + "\n"
                + "Text:\n"
                + comments);

        log.debug("Sending e-mail message: " + message);
        emailSender.send(message);

        ModelAndView mav = new ModelAndView("contact");
        mav.addObject("setProtocolToHttps", setProtocolToHttps);
        mav.addObject("sent", true);

        return mav;
    }

    @RequestMapping(value = "info/nominate", method = RequestMethod.POST)
    public ModelAndView sendNominateRequest(@RequestParam(value = "name", required = false) String name,
                                            @RequestParam(value = "email", required = false) String email,
                                            @RequestParam(value = "title", required = false) String title,
                                            @RequestParam(value = "url", required = false) String url,
                                            @RequestParam(value = "notes", required = false) String notes) throws MalformedURLException, URISyntaxException, ParseException {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(sendMailTo);
        message.setSubject("Nominate request [" + name + "]");
        message.setText("Request from: " + name +
                "\nContact e-mail: " + email + "\n"
                + "\n"
                + "Site title: " + title + "\n"
                + "Site Url: " + url + "\n"
                + "Additional information: \n"
                + notes);

        log.debug("Sending e-mail message: " + message);
        emailSender.send(message);

        ModelAndView mav = new ModelAndView("nominate");
        mav.addObject("setProtocolToHttps", setProtocolToHttps);
        mav.addObject("sent", true);

        return mav;
    }
}
