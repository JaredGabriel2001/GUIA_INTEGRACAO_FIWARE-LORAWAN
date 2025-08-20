#!/bin/bash

# Nome do arquivo do simulador para extrair a contagem de sensores
SIMULATOR_FILE="sensor_simulator_mosquitto.py"

# --- Validações Iniciais ---
# Verifica se o arquivo do simulador existe
if [ ! -f "$SIMULATOR_FILE" ]; then
    echo "Erro: O arquivo do simulador '$SIMULATOR_FILE' não foi encontrado."
    echo "Certifique-se de que este script está no mesmo diretório que o simulador."
    exit 1
fi

# Extrai o número de sensores diretamente do arquivo python
# Ele procura a linha com 'N_SENSORES', corta no '=', pega a segunda parte e remove espaços.
N_SENSORES=$(grep 'N_SENSORES =' "$SIMULATOR_FILE" | cut -d'=' -f2 | tr -d ' ')

# Verifica se a variável N_SENSORES foi extraída com sucesso
if [ -z "$N_SENSORES" ]; then
    echo "Erro: Não foi possível determinar o número de sensores (N_SENSORES) do arquivo '$SIMULATOR_FILE'."
    exit 1
fi

echo "Encontrado N_SENSORES = $N_SENSORES no arquivo '$SIMULATOR_FILE'."
echo "Iniciando o registro de $N_SENSORES sensores no FIWARE IoT Agent..."
echo "---"

# --- Loop de Registro ---
# Itera de 1 até o número de sensores
for i in $(seq 1 $N_SENSORES)
do
    # Define o ID do dispositivo e o nome da entidade dinamicamente
    DEVICE_ID="sensor_$i"
    # Usamos printf para formatar o número com 3 dígitos (001, 002, etc.)
    ENTITY_NAME="urn:ngsi-ld:SimulatedSensor:$(printf "%03d" $i)"

    echo "Registrando dispositivo: $DEVICE_ID com a entidade: $ENTITY_NAME"

    # Executa a requisição CURL para registrar o dispositivo no IoT Agent
    # A estrutura do payload é baseada no ConectarMosquittoLora.sh
    # Os atributos são baseados no sensor_simulator_mosquitto.py
    curl --location --request POST 'http://localhost:4041/iot/devices' \
    --header 'fiware-service: openiot' \
    --header 'fiware-servicepath: /' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "devices": [
            {
                "device_id": "'"$DEVICE_ID"'",
                "entity_name": "'"$ENTITY_NAME"'",
                "entity_type": "SimulatedSensor",
                "attributes": [
                    { "object_id": "count", "name": "count", "type": "Integer" },
                    { "object_id": "temperature", "name": "temperature", "type": "Float" },
                    { "object_id": "humidity", "name": "humidity", "type": "Float" }
                ],
                "internal_attributes": {
                    "lorawan": {
                        "application_server": {
                            "host": "mosquitto:1883",
                            "username": "",
                            "password": "",
                            "provider": "TTN"
                        },
                        "application_id": "demoLocal",
                        "data_model": "json"
                    }
                }
            }
        ]
    }'

    # Adiciona uma quebra de linha para melhor formatação da saída
    echo -e "\n---"
done

echo "Registro de todos os $N_SENSORES sensores concluído."