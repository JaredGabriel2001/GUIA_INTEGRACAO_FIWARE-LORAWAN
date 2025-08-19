mosquitto_pub -h localhost -t "application/demoLocal/device/teste07/up" \
-m '{"end_device_ids":{"device_id":"teste07"},"uplink_message":{"decoded_payload":{"count":500}}}'

