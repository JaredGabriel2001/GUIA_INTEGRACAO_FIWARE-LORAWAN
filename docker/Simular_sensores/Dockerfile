FROM python:3.12

WORKDIR /app
#copia tudo
COPY . .

# 1. Instala pip e limpa instalações prévias do NumPy
RUN pip install --upgrade pip 

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python3", "sensor_simulator_mosquitto.py"]