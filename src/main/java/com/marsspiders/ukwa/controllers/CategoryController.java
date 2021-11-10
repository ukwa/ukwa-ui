package com.marsspiders.ukwa.controllers;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.marsspiders.ukwa.controllers.data.CollectionDTO;
import com.marsspiders.ukwa.solr.SolrCategoryService;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.solr.client.solrj.response.PivotField;
import org.apache.solr.common.util.NamedList;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;
import static com.marsspiders.ukwa.util.UrlUtil.getLocale;
import static org.apache.commons.lang3.StringUtils.abbreviate;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = PROJECT_NAME + "/category")
public class CategoryController {
    private static final Logger log = LoggerFactory.getLogger(CategoryController.class);

    private static final String COLLECTION_ALT_MESSAGE_ID = "coll.alt.";

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @Autowired
    private SolrCategoryService categoryService;

    @Autowired
    private SolrSearchService searchService;

    @Autowired
    private MessageSource messageSource;


    @RequestMapping(value = "/v2", method = GET)
    public ModelAndView rootCategoriesPage(HttpServletRequest request) {

        Locale locale = getLocale(request);

        //-------------
        generateRootCollectionCategoriesDTOs(locale);
        //-------------


        List<HashMap<String, String>> listOfMapsOfItemsOfCategories = new ArrayList<>();
        HashMap<String, String> map = null;

        ObjectMapper objectMapper = new ObjectMapper();
        //---read from file
        String resourceName = "solr_CollectionAreas.json"; // ACT "act_allCollectionAreas.json";
        Path resourceDirectory = Paths.get("src","test", "data");
        String absolutePath = resourceDirectory.toFile().getAbsolutePath();
        InputStream input = null;
        try {
             input = new FileInputStream(absolutePath+"/"+resourceName);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        Category[] categories = null;
        try {
            categories = objectMapper.readValue(input, Category[].class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<String> categoriesList = new ArrayList<>();
        for (Category category : categories)
        {
            map = new HashMap<>();
            categoriesList.add(category.getTitle());
            if (category.getCollections_ids() != null && category.getCollections_ids().size() > 0)
            {
                for (int i=0; i<category.getCollections_ids().size(); i++)
                    map.put(searchService
                            .fetchCollectionById(category.getCollections_ids().get(i))
                            .getResponseBody().getDocuments()
                            .get(0).getName(), category.getCollections_ids().get(i));

                listOfMapsOfItemsOfCategories.add (map);
            }
        }
        ModelAndView mav = new ModelAndView("categoriesV1");
        mav.addObject("categoriesList", categoriesList);
        mav.addObject("listOfMapsOfItemsOfCategories", listOfMapsOfItemsOfCategories);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);

        return mav;
    }


    @RequestMapping(value = "", method = GET)
    public ModelAndView rootCategoriesPagev2(HttpServletRequest request) {
        Locale locale = getLocale(request);
        HashMap<Integer, String> categoriesHashMap = new HashMap<>();

        List<HashMap<String, String>> listOfMapsOfItemsOfCategories = new ArrayList<>();

        HashMap<String, String> map = null;


        NamedList<List<PivotField>> pivotEntryList = null;

        HashMap<Integer, String> categoriesHashMap2 = new HashMap<>();
        List <String> topLevelCategories = new ArrayList<>();

        HashMap<String, Object> test = new HashMap<>();
        HashMap<String, CollectionDTO> mapCollectionDTO = null;// new HashMap<>();
        List<CollectionDTO> listCollectionDTOs = new ArrayList<>();

        List<HashMap<String, List<CollectionDTO>>> listOfMapsOfItemsOfCategories2 = new ArrayList<>();

        List<HashMap<String, HashMap<String, CollectionDTO>>> listOfMapsOfItemsOfCategories3 = new ArrayList<>();

        try {
            log.info("------ pivots categories, BEFORE  ");
            pivotEntryList = categoryService.pivotQueryCategories();
            log.info("------ pivots categories, AFTER  ");

        } catch (Exception e) {
            e.printStackTrace();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        Category[] categories = null;

        //TODO: stream
        /*
        try {
            categories = objectMapper.readValue(pivotEntryList, Category[].class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        */


        CollectionDTO collectionDTO;
        //---------------
        for (Map.Entry<String, List<PivotField>> pivotEntry : pivotEntryList) {
            //pivotEntryList
            System.out.println("-------- PIVOT : FOR ");
            System.out.println("Key: " + pivotEntry.getKey());
            System.out.println("Value: " + pivotEntry.getValue().toString());
            //System.out.println("Value: " + pivotEntry.getValue().get(0));
            System.out.println("Value get (1) : " + pivotEntry.getValue().get(1));
            //System.out.println("Value: " + pivotEntry.getValue().get(2));

            //mapCollectionDTO = new HashMap<>();
            for (int y=0; y < pivotEntry.getValue().size();y++)
            {
                System.out.println("-------- PIVOT fieldValue = " + pivotEntry.getValue().get(y).getValue());

                if (pivotEntry.getValue().get(y).getPivot() != null){
                    System.out.println("---------- PIVOT subField getCount = " + pivotEntry.getValue().get(y).getCount());

                    //map = new HashMap<>();
                    //categoriesHashMap.put();//category.getKey(),category.getTitle());
                    //TODO: Top Level ID + names
                    //categoriesHashMap2.put(Integer.parseInt(pivotField.getValue()), "");
                    //List <String>
                    topLevelCategories.add(pivotEntry.getValue().get(y).getValue().toString());


                    mapCollectionDTO = new HashMap<>();

                    //add all collections that belong to category
                    // && TODO: sub-collections?
                    for (int z=0; z<pivotEntry.getValue().get(y).getPivot().size();z++)
                    {
                        pivotEntry.getValue().get(y).getPivot().get(z).getValue();
                        System.out.println("------------ PIVOT subField = " + pivotEntry.getValue().get(y).getPivot().get(z).getField() + ", " + pivotEntry.getValue().get(y).getPivot().get(z).getValue() );

                        //map version -------- HashMap<String, CollectionDTO>
                        mapCollectionDTO.put(
                                pivotEntry.getValue().get(y).getPivot().get(z).getValue().toString(),
                                new CollectionDTO(pivotEntry.getValue().get(y).getPivot().get(z).getValue().toString(), "test name", "coll descr", "coll full descr", "alt Image"));
                    }




                    //add all collections
                    // && TODO: sub-collections?
//                    pivotEntry.getValue().get(y).getPivot().forEach((subField) -> {
//                        System.out.println("------------ PIVOT subField = " + subField.getField() + ", " + subField.getValue() );
//
//                        //map version
//                        mapCollectionDTO.put(subField.getValue().toString(), new CollectionDTO(subField.getValue().toString(), "test name", "coll descr", "coll full descr", "alt Image"));
//
//                        //list version
//                        listCollectionDTOs.add(new CollectionDTO(subField.getValue().toString(), "test name", "coll descr", "coll full descr", "alt Image"));
//
//
////                        testCollectionDTO.put(
////                                pivotField.getValue().toString(),
////                                // id, name, descr, fullDescr, altImage
////                                new CollectionDTO(subField.getValue().toString(), "test name", "coll descr", "coll full descr", "alt Image"));
//                        //collectionDTO;
//
//
//                        // TODO: add description data
////                        if (subField.getPivot() != null){
////                            subField.getPivot().forEach((subSubField) -> {
////                                System.out.println("-------------- PIVOT subField pivot = " + subSubField.getField() + ", " + subSubField.getValue());
////                            });
////                        }
//
//                    });

                    //listOfMapsOfItemsOfCategories2.add(new HashMap<String, List<CollectionDTO>>() {{ pivotField.getValue().toString(), listCollectionDTOs}});

                    //pivotEntry.getValue().toString()

                    //listOfMapsOfItemsOfCategories2.add(new HashMap<String, List<CollectionDTO>>() {{ put(pivotField.getValue().toString(), listCollectionDTOs);}});


                    System.out.println("------------ PIVOT subField listCollectionDTOs size = " + listCollectionDTOs.size() );
                    //listCollectionDTOs.clear();
                }
                else{
                    System.out.println("-------- PIVOT subField = NULL ");
                }

                //List<HashMap<String, HashMap<String, CollectionDTO>>>
                HashMap<String, HashMap<String, CollectionDTO>> map3 = new HashMap<>();
                map3.put(pivotEntry.getValue().get(y).getValue().toString(), mapCollectionDTO);

                listOfMapsOfItemsOfCategories3.add(map3);
            }


//            pivotEntry.getValue().forEach((pivotField) -> {
//                //String fieldValue = pivotField.getValue() != null ? ((String) pivotField.getValue()).trim() : null;
//                System.out.println("-------- PIVOT fieldValue = " + pivotField.getValue());
//
//                if (pivotField.getPivot() != null){
//                    System.out.println("---------- PIVOT subField getCount = " + pivotField.getCount());
//
//                    //map = new HashMap<>();
//                    //categoriesHashMap.put();//category.getKey(),category.getTitle());
//                    //TODO: Top Level ID + names
//                    //categoriesHashMap2.put(Integer.parseInt(pivotField.getValue()), "");
//                    topLevelCategories.add(pivotField.getValue().toString());
//
//
////                    for (int x=0; x<pivotField.getPivot().size();x++){
////                        listCollectionDTOs.add(new CollectionDTO(subField.getValue().toString(), "test name", "coll descr", "coll full descr", "alt Image"));
////
////                    }
//
//
//                    //add all collections
//                    // && TODO: sub-collections?
//                    pivotField.getPivot().forEach((subField) -> {
//                        System.out.println("------------ PIVOT subField = " + subField.getField() + ", " + subField.getValue() );
//
//                        //map version
//                        mapCollectionDTO.put(subField.getValue().toString(), new CollectionDTO(subField.getValue().toString(), "test name", "coll descr", "coll full descr", "alt Image"));
//
//                        //list version
//                        listCollectionDTOs.add(new CollectionDTO(subField.getValue().toString(), "test name", "coll descr", "coll full descr", "alt Image"));
//
//
////                        testCollectionDTO.put(
////                                pivotField.getValue().toString(),
////                                // id, name, descr, fullDescr, altImage
////                                new CollectionDTO(subField.getValue().toString(), "test name", "coll descr", "coll full descr", "alt Image"));
//                        //collectionDTO;
//
//
//                        // TODO: add description data
////                        if (subField.getPivot() != null){
////                            subField.getPivot().forEach((subSubField) -> {
////                                System.out.println("-------------- PIVOT subField pivot = " + subSubField.getField() + ", " + subSubField.getValue());
////                            });
////                        }
//
//                    });
//
//                    //listOfMapsOfItemsOfCategories2.add(new HashMap<String, List<CollectionDTO>>() {{ pivotField.getValue().toString(), listCollectionDTOs}});
//
//                    //pivotEntry.getValue().toString()
//
//                    listOfMapsOfItemsOfCategories2.add(new HashMap<String, List<CollectionDTO>>() {{ put(pivotField.getValue().toString(), listCollectionDTOs);}});
//                    System.out.println("------------ PIVOT subField listCollectionDTOs size = " + listCollectionDTOs.size() );
//                    //listCollectionDTOs.clear();
//                }
//                else{
//                    System.out.println("-------- PIVOT subField = NULL ");
//                }
//
//            }); //foreach
        }

        //---------------
        System.out.println("-------- topMap List 3 size: " + listOfMapsOfItemsOfCategories3.size());

        listOfMapsOfItemsOfCategories3.forEach(topMap ->{
            topMap.entrySet().forEach(subMap ->{
                System.out.println("-------- submap getValue size : " + subMap.getValue().size() +", "+" getKey : " + subMap.getKey());
                subMap.getValue().entrySet().forEach(subSubMap -> {
                    System.out.println("-------- subSubMap getValue ID  : " + subSubMap.getValue().getId() +", Description : " + subSubMap.getValue().getDescription()+", Name : " + subSubMap.getValue().getName());

                });
            });
        });

        //-------------

//        ListIterator<String> listIterator = topLevelCategories.listIterator();
//        int j=0;
//        int z=0;
//        //List <String>
//        while (listIterator.hasNext()) {
//            //topLevelCategories.forEach(ids -> {
//
//            System.out.println("-----------topLevelCategories - ids: " + listIterator.next());
//            //List<HashMap<String, CollectionDTO>>
////            listOfMapsOfItemsOfCategories2.forEach(dto_hashMap->{
////                System.out.println("-------- dtos: " + dto_hashMap.entrySet());
////            });
//
//            listOfMapsOfItemsOfCategories3.get(j).entrySet().forEach(dto_hashMap -> {
//                System.out.println("-------- dto_hashmap getKey: " + dto_hashMap.getKey());
//                dto_hashMap.getValue().forEach(dto_2 ->{
//                            System.out.println("-------- dto_2 getValue ID  : " + dto_2.getId() +", "+"Description : " + dto_2.getDescription()+", Name : " + dto_2.getName());
//                        });
//
//            });
//            j++;
//
//            //});
//        }

        //---------------

        //TODO: remove after dynamic version will be implemented
        String resourceName = "solr_CollectionAreas.json"; // ACT "act_allCollectionAreas.json";
        InputStream input = this.getClass().getClassLoader().getResourceAsStream(resourceName);

        categories = null;
        try {
            categories = objectMapper.readValue(input, Category[].class);
        } catch (IOException e) {
            e.printStackTrace();
        }
        for (Category category : categories)
        {
            map = new HashMap<>();
            categoriesHashMap.put(category.getKey(),category.getTitle());

            if (category.getCollections_ids() != null && category.getCollections_ids().size() > 0)
            {
                for (int i=0; i<category.getCollections_ids().size(); i++)
                    map.put(searchService
                            .fetchCollectionById(category.getCollections_ids().get(i))
                            .getResponseBody().getDocuments()
                            .get(0).getName(), category.getCollections_ids().get(i));

                listOfMapsOfItemsOfCategories.add (map);
            }
        }
        ModelAndView mav = new ModelAndView("categoriesV2");
        mav.addObject("categoriesHashMap", categoriesHashMap);
        mav.addObject("listOfMapsOfItemsOfCategories", listOfMapsOfItemsOfCategories);
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

        //        List<CollectionDTO> collections = generateRootCollectionCategoriesDTOs(locale);

        log.info("-------------- Category process ");

        System.out.println(payload);
    }


    //------- cat
    private List<CollectionDTO> generateRootCollectionCategoriesDTOs(Locale locale) {

        SolrSearchResult<CollectionInfo> test = searchService
                .fetchRootCollectionsCategories();



        //log.info("--------- z" + test.toString());

        log.info("--------- getFacetCounts : " + test.getFacetCounts());
        log.info("--------- size : " + test.getResponseBody().getDocuments().size());

        //QueryResponse result = solr.query(query);
//        NamedList<List<PivotField>> facetPivot = result.getFacetPivot();
//        List<String> parsedPivotResult = parsePivotResult(facetPivot);
//        parsedPivotResult.forEach((s) -> {
//            System.out.println(s);
//        });


        Map<String, CollectionDTO> rootCollections = searchService
                .fetchRootCollectionsCategories()
                .getResponseBody().getDocuments()
                .stream()
                .collect(Collectors
                        .toMap(CollectionInfo::getId, collection -> toCollectionDTO(collection, true, locale)));

        log.info("--------- map print : " );

        for (Map.Entry<String, CollectionDTO> entry : rootCollections.entrySet()) {
            System.out.println(entry.getKey() + "/" + entry.getValue().getName());
        }
        //Set<String> parentCollectionIds = rootCollections.keySet();


        /*
        searchService
                .fetchChildCollections(parentCollectionIds, TYPE_COLLECTION, 1000, 0)
                .getResponseBody().getDocuments()
                .stream()
                .forEach(subCollection -> {
                    String parentId = subCollection.getParentId();

                    CollectionDTO parentCollectionDto = rootCollections.get(parentId);
                    if (parentCollectionDto.getSubCollections() == null) {
                        parentCollectionDto.setSubCollections(new ArrayList<>());
                    }

                    CollectionDTO subCollectionDTO = toCollectionDTO(subCollection, true, locale);
                    parentCollectionDto.getSubCollections().add(subCollectionDTO);

                });

        */

        //ArrayList<CollectionDTO> sortedCollectionDTOs = new ArrayList<>(rootCollections.values());
        //Collections.sort(sortedCollectionDTOs, (c1, c2) -> c1.getName().compareTo(c2.getName()));

        return null;//sortedCollectionDTOs;
    }
    //-------- cat

    private CollectionDTO toCollectionDTO(CollectionInfo collectionInfo, boolean abbreviate, Locale locale) {
        String id = collectionInfo.getId();
        String parentId = collectionInfo.getParentId();
        String name = collectionInfo.getName();
        String fullDescription = collectionInfo.getDescription() != null
                ? collectionInfo.getDescription().replaceAll("<[^>]*>", "")
                : null;

        String shortDescription = abbreviate
                ? abbreviate(fullDescription, 60)
                : fullDescription;

        String defaultImageAltMessage = "";
        String imageAltMessage = messageSource.getMessage(COLLECTION_ALT_MESSAGE_ID + id, null, defaultImageAltMessage, locale);

        return new CollectionDTO(id, parentId, name, shortDescription, fullDescription, imageAltMessage, 0, 0, 0);
    }

    /*
    * http://localhost:38983/solr/collections/select?
    *
    * fl=collectionAreaId&
    * fq=collectionAreaId:[*%20TO%20*]-collectionAreaId:(2945)&
    * indent=on&
    *
    * facet=true&
    * facet.limit=-1&
    * facet.pivot.mincount=1&
    * facet.pivot=collectionAreaId,id&
    *
    * q=*:*&
    * wt=json
    *
    * */

    private static List<String> parsePivotResult(final NamedList<List<PivotField>> pivotEntryList) {
        final Set<String> outputItems = new HashSet<>();
        for (final Map.Entry<String, List<PivotField>> pivotEntry : pivotEntryList) {
            System.out.println("Key: " + pivotEntry.getKey());
            pivotEntry.getValue().forEach((pivotField) -> {
                renderOutput(new StringBuilder(), pivotField, outputItems);
            });
        }
        final List<String> output = new ArrayList<>(outputItems);
        Collections.sort(output);
        return output;
    }

    private static void renderOutput(final StringBuilder sb, final PivotField field, final Set<String> outputItems) {
        String HIERARCHICAL_FACET_SEPARATOR = "-->";
        final String fieldValue = field.getValue() != null ? ((String) field.getValue()).trim() : null;
        final StringBuilder outputBuilder = new StringBuilder(sb);
        if (field.getPivot() != null) {
            if (outputBuilder.length() > 0) {
                outputBuilder.append(HIERARCHICAL_FACET_SEPARATOR);
            }
            outputBuilder.append(fieldValue);
            outputItems.add(new StringBuilder(outputBuilder).append(" (").append(field.getCount()).append(")").toString());
            field.getPivot().forEach((subField) -> {
                renderOutput(outputBuilder, subField, outputItems);
            });
        } else {
            if (outputBuilder.length() > 0) {
                outputBuilder.append(HIERARCHICAL_FACET_SEPARATOR);
            }
            outputBuilder.append(fieldValue);
            outputItems.add(outputBuilder.append(" (").append(field.getCount()).append(")").toString());
        }
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
