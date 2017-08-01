package com.marsspiders.ukwa;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Configuration
public class LocaleConfiguration extends WebMvcConfigurerAdapter {

    public static final String LOCALE_EN = "en";
    public static final String LOCALE_GD = "gd";
    public static final String LOCALE_CY = "cy";

    public static final String[] AVAILABLE_LOCALES = new String[]{LOCALE_EN, LOCALE_GD, LOCALE_CY};

    @Bean
    public LocaleResolver localeResolver() {
        return new LocaleResolver() {

            @Override
            public Locale resolveLocale(HttpServletRequest request) {
                return (Locale) request.getAttribute(LocaleResolverFilter.class.getName() + ".LOCALE");
            }

            @Override
            public void setLocale(HttpServletRequest request, HttpServletResponse response, Locale locale) {
                request.setAttribute(LocaleResolverFilter.class.getName() + ".LOCALE", locale);
            }
        };
    }

    @Bean
    public FilterRegistrationBean localeResolverFilterRegistrationBean() {
        FilterRegistrationBean registrationBean = new FilterRegistrationBean();
        registrationBean.setName("localeResolver");

        LocaleResolverFilter localeResolverFilter = new LocaleResolverFilter();
        registrationBean.setFilter(localeResolverFilter);
        registrationBean.setOrder(1);

        return registrationBean;
    }

    private class LocaleResolverFilter extends OncePerRequestFilter {
        private static final String DEFAULT_LOCALE = "en";

        @Override
        protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
                throws ServletException, IOException {
            String localeAttributeName = LocaleResolverFilter.class.getName() + ".LOCALE";

            List<String> requestParts = getUrlRequestParts(request);
            Locale urlLocale = getLocaleFromRequestParts(requestParts);

            if (urlLocale != null) {
                requestParts.remove(0);     //remove locale part from url
                String urlWithoutLocale = requestParts
                        .stream()
                        .map((s) -> "/" + s)
                        .collect(Collectors.joining(""));

                request.setAttribute(localeAttributeName, urlLocale);

                RequestDispatcher dispatcher = request.getRequestDispatcher(urlWithoutLocale);
                dispatcher.forward(request, response);
            } else {
                request.setAttribute(localeAttributeName, new Locale(DEFAULT_LOCALE));
                filterChain.doFilter(request, response);
            }
        }

        private List<String> getUrlRequestParts(ServletRequest request) {
            String[] pathParts = ((HttpServletRequest) request).getServletPath().split("/");
            List<String> result = new ArrayList<>();

            for (String sp : pathParts) {
                if (sp.trim().length() > 0)
                    result.add(sp);
            }

            return result;
        }

        private Locale getLocaleFromRequestParts(List<String> parts) {
            if (parts.size() == 0) {
                return null;
            }

            for (String lang : AVAILABLE_LOCALES) {
                if (lang.equals(parts.get(0))) {
                    return new Locale(lang);
                }
            }

            return null;
        }
    }

}