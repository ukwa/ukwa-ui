package com.marsspiders.ukwa;

import com.marsspiders.ukwa.ip.WaybackIpResolver;
import com.marsspiders.ukwa.solr.SolrCommunicator;
import com.marsspiders.ukwa.solr.SolrSearchService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@SpringBootApplication
public class ApplicationConfiguration extends SpringBootServletInitializer {

    public static void main(String[] args) throws Exception {
        SpringApplication.run(ApplicationConfiguration.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(ApplicationConfiguration.class);
    }

    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("classpath:/i18n/messages");
        messageSource.setDefaultEncoding("UTF-8");
        return messageSource;
    }


    @Bean
    SolrSearchService solrSearchService() {
        return new SolrSearchService();
    }
    @Bean
    SolrCommunicator solrCommunicator() {
        return new SolrCommunicator();
    }
    @Bean
    WaybackIpResolver waybackIpResolver() {
        return new WaybackIpResolver();
    }
    @Bean
    WaybackIpConfiguration waybackIpConfiguration() {
        return new WaybackIpConfiguration();
    }
    /*
    @Bean
    JavaMailSender javaMailSender() {
        return new JavaMailSender();
    }
    */

    @Bean
    public JavaMailSender getJavaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

        /*
        mailSender.setHost("smtp.gmail.com");//spring.mail.host
        mailSender.setPort(587);
        mailSender.setUsername("my.gmail@gmail.com");
        mailSender.setPassword("password");
        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");
        */

        return mailSender;
    }





}
