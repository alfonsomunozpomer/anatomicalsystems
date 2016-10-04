#! /bin/bash
# $1: log location
# $2: UBERONid of anatomical system
# $3: page to retrieve

descendants(){
curl -s "http://www.ebi.ac.uk/ols/api/ontologies/uberon/terms/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252F$1/hierarchicalDescendants?size=1000&page=$2"  \
 | jq -r '._embedded.terms | map (.short_form +"|"+ .label+"\n") | add' | grep '[^[:blank:]]'| sort -u
}

descendants $2 $3 2> >(xargs -0  printf "Error| $2 | $3 | %s\n"  >> $1 ) | tee -a >(wc -l | xargs printf "Out| $2 | $3 | %s\n"  >> $1)
