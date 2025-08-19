curl --location --request POST 'http://localhost:4041/iot/devices' \
--header 'fiware-service: openiot' \
--header 'fiware-servicePath: /airQuality' \
--header 'Content-Type: application/json' \
--data-raw '{
  "devices": [
    {
      "device_id": "teste07",
      "entity_name": "urn:ngsi-ld:teste07",
      "entity_type": "Thing",
      "resource": "urn:ngsi-ld:teste07",
      "attributes": [
        { "object_id": "count", "name": "count", "type": "Integer" }
      ],
      "internal_attributes": {
        "lorawan": {
          "application_server": {
            "host": "mosquitto:1883",
            "username": "",
            "password": "",
            "provider": "TTN"
          },
          "app_eui": "localApp",
          "application_id": "demoLocal",
          "application_key": "fakeKey123",
          "data_model": "json"
        }
      }
    }
  ]
}'
