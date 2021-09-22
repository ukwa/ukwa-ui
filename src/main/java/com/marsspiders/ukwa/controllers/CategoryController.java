package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.controllers.data.CollectionDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;
import static com.marsspiders.ukwa.util.UrlUtil.getLocale;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = PROJECT_NAME + "/category")
public class CategoryController {
    private static final Logger log = LoggerFactory.getLogger(CategoryController.class);

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = "", method = GET)
    public ModelAndView rootCategoriesPage(HttpServletRequest request) {
        Locale locale = getLocale(request);

        //List<CollectionDTO> categories = generateRootCategoriesDTOs(locale);

        //------------------ test set 1 ----------
        List<String> itemsOfCategories = new ArrayList<String>();
        itemsOfCategories.add("19th Century English Literature");
        itemsOfCategories.add("British Overseas Territories");
        itemsOfCategories.add("European Parliament Elections 2009");
        itemsOfCategories.add("First World War Centenary, 2014-18");
        itemsOfCategories.add("Health and Social Care Act 2012 - NHS Reforms");
        itemsOfCategories.add("Northern Irish Churches");
        itemsOfCategories.add("Royal Colleges of Health and Medicine");
        itemsOfCategories.add("Sports: International Events");
        itemsOfCategories.add("Poetry Zines and Journals");

        //------------------ test set 2 ?



        ModelAndView mav = new ModelAndView("categoriesV1");
        mav.addObject("itemsOfCategories", itemsOfCategories);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);

        return mav;
    }

    @RequestMapping(value = "/{categoryId}", method = GET)
    public ModelAndView getCategoryById(@PathVariable("categoryId") String collectionId) {
        ModelAndView modelAndView = new ModelAndView("categoriesV1");
        return modelAndView;
    }


}
