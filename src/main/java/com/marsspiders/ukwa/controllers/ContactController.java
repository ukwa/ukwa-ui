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
@RequestMapping(value = PROJECT_NAME + "/contact")
public class ContactController {
    private static final Log log = LogFactory.getLog(ContactController.class);

    @Value("${bl.send.mail.to}")
    private String sendMailTo;

    @Autowired
    public JavaMailSender emailSender;

    @RequestMapping(value = "feedback", method = RequestMethod.POST)
    public ModelAndView sendFeedback(@RequestParam(value = "name", required = false) String name,
                                     @RequestParam(value = "mail", required = false) String mail,
                                     @RequestParam(value = "text", required = false) String text) {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(sendMailTo);
        message.setSubject("Contact form request [" + name + "]");
        message.setText("Request from: " + name + "\n"
                + "Contact e-mail: " + mail + "\n"
                + "\n"
                + "Text:\n"
                + text);

        emailSender.send(message);

        ModelAndView mav = new ModelAndView("contact");
        return mav;
    }

    @RequestMapping(value = "nominate", method = RequestMethod.POST)
    public ModelAndView sendNominateRequest(@RequestParam(value = "name", required = false) String name,
                                            @RequestParam(value = "mail", required = false) String mail,
                                            @RequestParam(value = "title", required = false) String title,
                                            @RequestParam(value = "url", required = false) String url,
                                            @RequestParam(value = "text", required = false) String text) throws MalformedURLException, URISyntaxException, ParseException {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(sendMailTo);
        message.setSubject("Nominate request [" + name + "]");
        message.setText("Request from: " + name +
                "\nContact e-mail: " + mail + "\n"
                + "\n"
                + "Site title: " + title + "\n"
                + "Site Url: " + url + "\n"
                + "Additional information: \n"
                + text);

        emailSender.send(message);

        ModelAndView mav = new ModelAndView("nominate");
        return mav;
    }
}
