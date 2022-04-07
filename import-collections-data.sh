curl -X POST -H 'Content-Type:application/json' http://localhost:38983/solr/collections/update --data @src/test/data/collection-1m2.json
curl http://localhost:38983/solr/collections/update?commit=true
