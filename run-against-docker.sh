#!/bin/sh
export SOLR_COLLECTION_SEARCH_PATH=http://localhost:8984
export SOLR_COLLECTION_REQUEST_HANDLER=/solr/collections/select
export SOLR_FULL_TEXT_SEARCH_PATH=http://localhost:8983
export SOLR_FULL_TEXT_SEARCH_REQUEST_HANDLER=/solr/discovery/select
export BL_SMTP_SERVER_HOST="mailhost"
export BL_SMTP_USERNAME="mailuser"
export BL_SMTP_PASSWORD="mailpassword"

docker-compose up -d solr-collections solr-search

sass src/main/resources/static/ukwa/scss/main.scss src/main/resources/static/ukwa/css/main.css
mvn spring-boot:run
