curl -X POST -H 'Content-Type:application/json' http://localhost:8984/solr/collections/update --data @src/test/data/collections-solr-docs.json 
curl http://localhost:8984/solr/collections/update?commit=true
