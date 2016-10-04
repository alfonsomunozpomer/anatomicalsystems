
echo -ne "Retrieving anatomical systems...\r"
curl -s http://www.ebi.ac.uk/ols/api/ontologies/uberon/terms/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FUBERON_0000467/children?size=1000 \
| jq -r '._embedded.terms | map (.short_form +"|"+ .label+"\n") | add' | grep '[^[:blank:]]'| sort | uniq \
 > out/all_systems
echo "Retrieved $(cat out/all_systems | wc -l) systems             "



one_system()
{
if [ -f log/$1 ] && [ $(grep -c Error log/$1) -eq 0 ] && [ -f out/$1 ] && [ $(cat out/$1 | wc -l ) -gt 0 ]
then
   echo "Skipping $1  ...                               "
else
  echo  -ne "Refreshing $1 ...                         \r"
  rm out/$1 2> /dev/null
   ./paged_descendants.sh $1
fi

}

for SYSTEM in $(cat out/all_systems | cut -f1 -d '|')
  do one_system $SYSTEM
done

echo -ne "Done! Errors: "
find ./log -type f | xargs grep Error
