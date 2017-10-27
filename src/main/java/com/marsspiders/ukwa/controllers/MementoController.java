package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.models.Query;
import com.marsspiders.ukwa.models.Screenshot;
import com.marsspiders.ukwa.models.memento.MementoQuery;
import com.marsspiders.ukwa.models.memento.MementoTimeGraph;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import java.lang.reflect.Array;
import java.util.List;

import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;

@Controller
@RequestMapping(value = PROJECT_NAME + "/mementos")
public class MementoController {
    private static Logger logger = LoggerFactory.getLogger(MementoController.class);

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ModelAndView findMementos(HttpServletRequest httpServletRequest,
                                     @RequestParam(value = "url", required = true) String url){
        ModelAndView modelAndView = new ModelAndView("memento");
        /*String url = new AntPathMatcher()
                .extractPathWithinPattern( PROJECT_NAME + "/mementos/search/**", httpServletRequest.getRequestURI() );*/

        MementoQuery msb = doQuery(url, "");
        // Check for warnings:
        /*if( msb.getErrorMessage() != null )
            flash("success", msb.getErrorMessage() );*/
        // Rebuild a Query object.
        modelAndView.addObject("url", url);
        modelAndView.addObject("msb", msb);

        return modelAndView;
    }

    private static MementoQuery doQuery(String url, String archive) {
        String queryId = "Mementos." + archive + "." + url;
        //Logger.debug("Query: "+queryId);
        MementoQuery msb; /*= (MementoQuery) Cache.get(queryId);
        if( msb == null ) {*/
            //Logger.debug("Cache miss, querying timegate: "+queryId);
            msb = new MementoQuery();
            msb.setUrlAndArchive(url,archive);
            // Only cache if it worked:
            /*if( msb.hasValidResults()) {
                Cache.set(queryId, msb, CACHE_TIMEOUT);
            }
        }*/
        return msb;
    }

    @RequestMapping(value = "/api/timegraph", method = RequestMethod.GET)
    public @ResponseBody List<MementoTimeGraph.Series> apiTimeGraph(
            @RequestParam(value = "url", required = true) String url,
            @RequestParam(value = "archive", required = false) String archive) {
        MementoQuery msb = doQuery(url, archive);
        return MementoTimeGraph.makeYearwiseData(msb);
    }

    @RequestMapping(value = "/api/screenshot", method = RequestMethod.GET)
    public ResponseEntity<byte[]> apiScreenshot(@RequestParam(value = "url", required = true) String url) {
        try {
            Screenshot shot; /*= (Screenshot) Cache.get("Screenshot."+url);
            if( shot == null ) {*/
                logger.debug("Started taking screenshot of " + url);
                shot = Screenshot.getThumbnailPNG(url);
                logger.debug("Finished taking screenshot of " + url);
                //Cache.set("Screenshot."+url, shot, CACHE_TIMEOUT);
            //}
            return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(shot.screenshot);
        }
        catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new byte[]{});
        }
    }
}
