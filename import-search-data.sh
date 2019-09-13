
# Importing documents dumped from the real Solr, but after stripping out the _version_ and resourcename_facet fields as Solr creates those
# 
#  jq .response.docs searchsol.json > search-solr-docs.json
# jq 'del(.[]|._version_)' search-solr-docs.json > search-solr-docs-no-versions.json
# jq 'del(.[]|.resourcename_facet)' search-solr-docs-no-versions.json > search-solr-docs-no-versions-no-resourcename_facet.json

curl -X POST -H 'Content-Type:application/json' http://localhost:8983/solr/discovery/update --data @search-solr-docs-no-versions-no-resourcename_facet.json
curl http://localhost:8983/solr/discovery/update?commit=true


