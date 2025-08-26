#curl -s -G 'http://localhost:1026/v2/entities/urn:ngsi-ld:SimulatedSensor:001' \
#  -H 'fiware-service: openiot' \
#  -H 'fiware-servicepath: /'

curl --location --request GET 'http://localhost:1026/v2/entities/urn:ngsi-ld:SimulatedSensor:001' \
  --header 'fiware-service: openiot' \
  --header 'fiware-servicepath: /'
