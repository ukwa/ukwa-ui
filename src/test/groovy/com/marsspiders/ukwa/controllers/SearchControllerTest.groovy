package com.marsspiders.ukwa.controllers

import com.marsspiders.ukwa.WaybackIpConfiguration
import com.marsspiders.ukwa.ip.WaybackIpResolver
import com.marsspiders.ukwa.solr.SolrCommunicator
import com.marsspiders.ukwa.solr.SolrSearchService
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.test.web.servlet.MockMvc
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Bean
import org.springframework.boot.test.context.TestConfiguration
import spock.mock.DetachedMockFactory

/**
 * A Spock Spring MVC test that doesn't require a full spring context
 */
@WebMvcTest
class SearchControllerTest extends spock.lang.Specification {
    @Autowired
    MockMvc mockMvc
    @Autowired
    SearchController searchController
    @Autowired
    SolrSearchService solrSearchService

    //mvc modelandview parameterized - integrated test in searchController searchPage
    def "user sets search parameters and gets view"() {
        given:
        searchController.searchService = solrSearchService
        when:
        def result = searchController.searchPage (
                "1", "2", "3",
                (String[]) ["a", "b"],
                (String[]) ["c", "d"],
                (String[]) ["e", "f"],
                "4", "5",
                (String[]) ["g", "h"],
                (String[]) ["i", "j"],
                "6", "7", "8", null)
        def keySet = ['originalSearchRequest',
                      'originalSearchLocation',
                      //originalContentTypes:[a, b], originalPublicSuffixes:[c, d], originalDomains:[e, f]
                      'originalFromDateText',
                      'originalToDateText']
        then:
        //Total elements in MVC Model View result.getModelMap().keySet().size() == 26
        assert ['2','1','4', '5'] == result.getModelMap().findResults{k,v -> k in keySet ? v : null}
    }

    @TestConfiguration
    static class MockConfig {
        def detachedMockFactory = new DetachedMockFactory()
        @Bean
        SolrSearchService solrSearchService() {
            return detachedMockFactory.Stub(SolrSearchService)
        }
        @Bean
        SolrCommunicator solrCommunicator() {
            return detachedMockFactory.Stub(SolrCommunicator)
        }
        @Bean
        WaybackIpResolver waybackIpResolver() {
            return detachedMockFactory.Stub(WaybackIpResolver)
        }
        @Bean
        WaybackIpConfiguration waybackIpConfiguration() {
            return detachedMockFactory.Stub(WaybackIpConfiguration)
        }
        @Bean
        JavaMailSender javaMailSender() {
            return detachedMockFactory.Stub(JavaMailSender)
        }
    }
}