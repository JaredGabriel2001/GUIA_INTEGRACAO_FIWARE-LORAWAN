import time
import json
import random
import paho.mqtt.client as mqtt #pip3 install paho-mqtt

# Configurações do broker
BROKER = "mosquitto"   
PORT = 1883
TOPIC_TEMPLATE = "application/demoLocal/device/{}/up"

# Configurações do simulador
N_SENSORES = 5       # número de sensores
INTERVALO = 10       # segundos entre publicações

# Conecta no broker
client = mqtt.Client()
client.connect(BROKER, PORT, 60)

print(f"Simulando {N_SENSORES} sensores, publicando a cada {INTERVALO}s...")
try:
    while True:
        for i in range(1, N_SENSORES + 1):
            device_id = f"sensor_{i}"
            payload = {
                "end_device_ids": {"device_id": device_id},
                "uplink_message": {
                    "decoded_payload": {
                        "count": random.randint(0, 1000),
                        "temperature": round(random.uniform(20, 30), 2),
                        "humidity": round(random.uniform(40, 80), 2)
                    }
                }
            }
            topic = TOPIC_TEMPLATE.format(device_id)
            client.publish(topic, json.dumps(payload))
            print(f"[OK] Publicado em {topic}: {payload}")
        time.sleep(INTERVALO)

except KeyboardInterrupt:
    print("\nSimulação encerrada.")
    client.disconnect()
