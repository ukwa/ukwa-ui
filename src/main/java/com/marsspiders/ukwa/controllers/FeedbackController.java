package com.marsspiders.ukwa.controllers;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.noggit.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.json.JsonParser;
import org.springframework.boot.json.JsonParserFactory;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.Proxy;
import java.util.Map;

import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;

@Controller
@RequestMapping(value = PROJECT_NAME)
public class FeedbackController {
    private static final Log log = LogFactory.getLog(FeedbackController.class);

    // Note that site key is picked up in HomeController
    @Value("${google.recaptcha.secret.key}")
    private String gRecaptchaSecretKey;

    @Value("${bl.send.mail.to}")
    private String sendMailTo;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @Autowired
    public JavaMailSender emailSender;

    @RequestMapping(value = "contact", method = RequestMethod.POST)
    public ModelAndView sendFeedback(@RequestParam(value = "name", required = false) String name,
                                     @RequestParam(value = "email", required = false) String email,
                                     @RequestParam(value = "comments", required = false) String comments,
                                     @RequestParam(value = "g-recaptcha-response", required = true) String gRecaptchaResponse ) {

        // Check Captcha worked:
        this.checkCaptcha(gRecaptchaResponse);

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
                                            @RequestParam(value = "notes", required = false) String notes,
                                            @RequestParam(value = "g-recaptcha-response", required = true) String gRecaptchaResponse ) throws MalformedURLException, URISyntaxException, ParseException {

        // Check Captcha worked:
        this.checkCaptcha(gRecaptchaResponse);

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

    /**
     * Shared utility to handle validation and response.
     * 
     * @param gRecaptchaResponse
     * @return
     */
    private boolean checkCaptcha(String gRecaptchaResponse) {
        log.info("Validating ReCAPTCHA " + gRecaptchaResponse.substring(0, 10) + "...");
        boolean passed = this.isCaptchaValid(this.gRecaptchaSecretKey, gRecaptchaResponse);
        if( !passed ) {
            log.info("ReCAPTCHA " + gRecaptchaResponse.substring(0, 10) + "... failed!");
            throw new RuntimeException("ReCAPTCHA Validation Failed!");
        }
        log.info("ReCAPTCHA " + gRecaptchaResponse.substring(0, 10) + "... passed!");
        return passed;
    }

    /**
     * Validates Google reCAPTCHA V2 or Invisible reCAPTCHA.
     *
     * @param secretKey Secret key (key given for communication between your
     *                  site and Google)
     * @param response  reCAPTCHA response from client side.
     *                  (g-recaptcha-response)
     * @return true if validation successful, false otherwise.
     */
    private synchronized boolean isCaptchaValid(String secretKey, String response) {
        try {
            String url = "https://www.google.com/recaptcha/api/siteverify",
                    params = "secret=" + secretKey + "&response=" + response;

            String proxyHost = System.getenv().getOrDefault("CAPTCHA_PROXY_HOST", null);
            String proxyPort = System.getenv().getOrDefault("CAPTCHA_PROXY_PORT", null);

            HttpURLConnection http;
            if( proxyHost != null ) {
                Proxy proxy = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(proxyHost, Integer.parseInt(proxyPort)));
                http = (HttpURLConnection) new URL(url).openConnection(proxy);
            } else {
                http = (HttpURLConnection) new URL(url).openConnection();
            }
            http.setDoOutput(true);
            http.setConnectTimeout(30*1000);
            http.setRequestMethod("POST");
            http.setRequestProperty("Content-Type",
                    "application/x-www-form-urlencoded; charset=UTF-8");
            OutputStream out = http.getOutputStream();
            out.write(params.getBytes("UTF-8"));
            out.flush();
            out.close();

            InputStream res = http.getInputStream();
            BufferedReader rd = new BufferedReader(new InputStreamReader(res, "UTF-8"));

            StringBuilder sb = new StringBuilder();
            int cp;
            while ((cp = rd.read()) != -1) {
                sb.append((char) cp);
            }
            JsonParser springParser = JsonParserFactory.getJsonParser();
            Map<String,Object> json = springParser.parseMap(sb.toString());
            res.close();

            return (Boolean)json.get("success");
        } catch (Exception e) {
            log.error("Verifying ReCAPTCHA failed!", e);
        }
        return false;
    }
}
