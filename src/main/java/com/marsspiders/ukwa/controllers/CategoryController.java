package com.marsspiders.ukwa.controllers;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.marsspiders.ukwa.controllers.data.CollectionDTO;
import com.marsspiders.ukwa.solr.SolrCategoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;
import static com.marsspiders.ukwa.util.UrlUtil.getLocale;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@Controller
@RequestMapping(value = PROJECT_NAME + "/category")
public class CategoryController {
    private static final Logger log = LoggerFactory.getLogger(CategoryController.class);

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    //@Autowired
    //SolrCategoryService categoryService;

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

        ObjectMapper objectMapper = new ObjectMapper();

        String resourceName = "act_allCollectionAreas.json";
        Path resourceDirectory = Paths.get("src","test", "data");
        String absolutePath = resourceDirectory.toFile().getAbsolutePath();

        InputStream input = null;
        try {
             input = new FileInputStream(absolutePath+"/"+resourceName);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }


        System.out.println("----- absolutePath : " + absolutePath);

        Category[] categories = null;
        try {
            categories = objectMapper.readValue(input, Category[].class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (categories != null)
            System.out.println("----- categories != null : " + categories.length);
        else
            System.out.println("----- categories == null : " );

        List<String> categoriesList = new ArrayList<>();

        for (Category category : categories)
        {
            categoriesList.add(category.getTitle());

            if (category.getCollections_ids() != null && category.getCollections_ids().size() > 0)
            {
                for (int i=0; i<category.getCollections_ids().size(); i++)
                itemsOfCategories.add(category.getCollections_ids().get(i));

            }
        }


        ModelAndView mav = new ModelAndView("categoriesV1");
        mav.addObject("categoriesList", categoriesList);
        mav.addObject("itemsOfCategories", itemsOfCategories);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);

        return mav;
    }

    @RequestMapping(value = "/{categoryId}", method = GET)
    public ModelAndView getCategoryById(@PathVariable("categoryId") String collectionId) {
        ModelAndView modelAndView = new ModelAndView("categoriesV1");
        return modelAndView;
    }

    @RequestMapping(
            value = "/process",
            method = RequestMethod.POST,
            consumes = "text/plain")
    public void process(@RequestBody String payload) throws Exception {
        log.info("-------------- Category process ");

        System.out.println(payload);
    }

    @RequestMapping(
            value = "/process2",
            method = RequestMethod.POST)
    public void process2(@RequestBody Map<String, Object>[] payload)
            throws Exception {
        log.info("-------------- Category process 2");


        System.out.println(payload);

    }

//    @RequestMapping(value = "/test", method = GET)
//    public String getCategoryList(){//@PathVariable("categoryId") String collectionId) {
//        //ModelAndView modelAndView = new ModelAndView("categoriesV1");
//        //return modelAndView;
//        log.info("-------------- get Category List");
//        return categoryService.fetchCategories();
//    }

//    //arbitrary Json in Spring-Boot, you can simply use Jackson's JsonNode
//    @PostMapping(value="/process3")
//    public void process3(@RequestBody com.fasterxml.jackson.databind.JsonNode payload) {
//        log.info("-------------- Category process 3 ");
//
//
//
//        Iterator<Map.Entry<String, JsonNode>> fields = payload.fields();
//        while(fields.hasNext()) {
//            Map.Entry<String, JsonNode> field = fields.next();
//            String   fieldName  = field.getKey();
//            JsonNode fieldValue = field.getValue();
//
//            System.out.println(fieldName + " = " + fieldValue.asText());
//        }
//
//        /*
//        System.out.println(" Lambda version ");
//
//        Iterator<JsonNode> iterator = payload.withArray("datasets").elements();
//        while (iterator.hasNext())
//            System.out.print(iterator.next().toString() + " ");
//        */
//        /*
//        String jsonStr = "{\"Technologies\" : [\"Java\", \"Scala\", \"Python\"]}";
//
//        ObjectMapper mapper = new ObjectMapper();
//        ArrayNode arrayNode = null;
//        try {
//            arrayNode = (ArrayNode) mapper.readTree(jsonStr).get("Technologies");
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        if(arrayNode.isArray()) {
//            for(JsonNode jsonNode : arrayNode) {
//                System.out.println(jsonNode);
//            }
//        }
//        */
//
//        System.out.println("SOLR data: " + categoryService.fetchCategories());
//
//        // create object mapper class
//        ObjectMapper mapper = new ObjectMapper();
//        // convert json string to JsonNode
//        JsonNode jsonNode = null;
//        try {
//            jsonNode = mapper.readTree(categoryService.fetchCategories().getBytes());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        // check whether the node arraytype or not
//        if (jsonNode.get("docs") != null && jsonNode.get("docs").isArray()) {
//            // convert to array node
//            ArrayNode arrayNode = (ArrayNode) jsonNode.get("docs");
//
//            // iterate over this arraynode
//            for (JsonNode node : arrayNode) {
//                // print the text value
//                System.out.println(node.textValue());
//            }
//        }
//        else
//        {
//            System.out.println("------ nothing docs!-------");
//
//        }
//
//
//        if (jsonNode.get("groups") != null && jsonNode.get("groups").isArray()) {
//            // convert to array node
//            ArrayNode arrayNode = (ArrayNode) jsonNode.get("groups");
//
//            // iterate over this arraynode
//            for (JsonNode node : arrayNode) {
//                // print the text value
//                System.out.println(node.textValue());
//            }
//        }
//        else
//        {
//            System.out.println("------ nothing group!-------");
//
//        }
//
//        if (jsonNode.get("grouped") != null && jsonNode.get("grouped").isArray()) {
//            // convert to array node
//            ArrayNode arrayNode = (ArrayNode) jsonNode.get("grouped");
//
//            // iterate over this arraynode
//            for (JsonNode node : arrayNode) {
//                // print the text value
//                System.out.println(node.textValue());
//            }
//        }
//        else
//        {
//            System.out.println("------ nothing!-------");
//
//        }
//    }
}

@JsonIgnoreProperties(ignoreUnknown = true)
class Category {

    public Integer getKey() {
        return key;
    }

    public void setKey(Integer key) {
        this.key = key;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<String> getCollections_ids() {
        return collections_ids;
    }

    public void setCollections_ids(List<String> collections_ids) {
        this.collections_ids = collections_ids;
    }

    private Integer key;
    private String  title;
    //private String  url;
    //private String  select;
    //private String  children;
    private List<String> collections_ids;


}
