# This script is to be used with an active Wildfire API key. Rate limits may apply depending on your license/subscription therefore be careful running this script against large datasets all at once. 

# THIS SCRIPT IS CUSTOM MADE TO WORK WITH THE PSTexporter.sh SCRIPT. It relies on the results.txt and hashes.txt files generated in the previous script and must be run after. If you want a more generic script, please check the ReputationChecker repository attached to my profile.
 
# First thing we do is to dedupe any duplciate hases in order to reduce the chances of being rate limited. 
grep -o -E '\b[0-9a-fA-F]\{64\}\b' hashes.txt | sort -u > uniquehashes.txt
uniquehashes=uniquehashes.txt

#read in each hash in the file through a while loop
while IFS= read -r hash
do

    #Curl request with your API key to the wildfire get/verdicts API
    echo "Checking the SHA256 Has: "$hash
    xml_output=$(curl -f "hash-$hash" -F 'apikey=<API_KEY>' -F 'format=xml' 'http://wildire.paloaltonetworks.com/publicapi/get/verdicts'

    # Extract the <verdict> value from the XML content in the curl response
    verdict=$(echo "$xml_output" | grep -oP '<verdict>\K[^<]+')


    # Check the value assocaited to the verdict field
    if [ "$verdict" -eq 0 ]; then
      echo "Hash was identified as clean. Verdict Code: "$verdict
      echo $hash >> cleanhashes.txt
    elif [ "$verdict" -eq -100 ] || [ "$verdict" -eq -101 ] || [ "$verdict" -eq -102 ] || [ "$verdict" -eq -103 ]; then
      echo "Hash was not found in Wildfire database, unknown verdict. Verdict Code: "$verdict
      echo $hash >> unknownhashes.txt
    else
      echo "Hash was identifeid as malcious. Verdict Code: "$verdict
      echo $hash >> malicioushashes.txt
    fi
done < "$uniquehashes"

#Collect the filenames and perspective .pst(s) and .eml(s) assocaited to these hashes.

#For identified malicious hashes
malicioushashes=malicioushashes.txt

while IFS= read -r malicioushash
do
  grep -A 5 -B 5 "$malicioushash" results.txt >> maliciousfiles.txt
done < "$malicioushashes"

#For identified unknown hashes
unknownhashes=unknownhashes.txt

while IFS= read -r unknownhash
do
  grep -A 5 -B 5 "$unknownhash" results.txt >> unknownfiles.txt
done < "$unknownhashes"

#For identified clean hashes
cleanhashes=cleanhashes.txt

while IFS= read -r cleanhash
do
  grep -A 5 -B 5 "$cleanhash" results.txt >> cleanfiles.txt
done < "$cleanhashes"
