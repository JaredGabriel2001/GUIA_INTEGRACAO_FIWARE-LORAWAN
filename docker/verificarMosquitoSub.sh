docker exec -it mosquitto /bin/sh
mosquitto_sub -h localhost -t "application/demoLocal/device/teste07/up"
