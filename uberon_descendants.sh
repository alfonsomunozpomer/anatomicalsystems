#! /bin/sh
curl -s "http://www.ebi.ac.uk/ols/api/ontologies/uberon/terms/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252F$1/hierarchicalDescendants?size=1000&page=$2"  | jq -r '._embedded.terms | map (.short_form +"|"+ .label+"\n") | add' | grep '[^[:blank:]]'| sort -u
