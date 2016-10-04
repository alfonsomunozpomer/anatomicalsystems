#! /bin/sh
#1 : UBERON id
LOG="./log/$1"
OUT="./out/$1"
TMP=".tmp~$1"
PAGES=$(curl -s http://www.ebi.ac.uk/ols/api/ontologies/uberon/terms/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252F$1/hierarchicalDescendants?size=1000 \
  | jq -r '.page.totalPages')
if [ $PAGES -eq 0 ]
then
  echo "Found no data for for $1"
else
  printf "Pages | $1 | $PAGES\n" >> $LOG
  seq 0 $[PAGES-1] | xargs -n 1 -P 10 ./task.sh $LOG $1 >> $OUT
  mv $OUT $TMP
  sort -u $TMP > $OUT
  echo "Retrieved $(cat $OUT | wc -l ) descendants for $1"
  rm $TMP
fi
