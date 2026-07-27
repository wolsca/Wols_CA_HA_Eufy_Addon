#!/usr/bin/env bash
set -e

echo "[INFO] Wols CA Eufy HA Bridge is initializing..."

# 1. Lees configuratie uit Home Assistant in
CONFIG_PATH=/data/options.json

if [ -f "$CONFIG_PATH" ]; then
    echo "[INFO] Loading configuration from Home Assistant..."
    
    # Koppel de exacte UI-sleutels (zoals EUFY_USER) aan de Environment Variables
    export EUFY_USERNAME=$(jq --raw-output '.EUFY_USER // empty' $CONFIG_PATH)
    export EUFY_PASSWORD=$(jq --raw-output '.EUFY_PASS // empty' $CONFIG_PATH)
    
    # Haal ook direct jouw MQTT instellingen uit de UI
    export MQTT_HOST=$(jq --raw-output '.MQTT_HOST // "127.0.0.1"' $CONFIG_PATH)
    export MQTT_PORT=$(jq --raw-output '.MQTT_PORT // "1883"' $CONFIG_PATH)
    export MQTT_USER=$(jq --raw-output '.MQTT_USER // empty' $CONFIG_PATH)
    export MQTT_PASS=$(jq --raw-output '.MQTT_PASS // empty' $CONFIG_PATH)
    
    export EUFY_COUNTRY="NL"
    export EUFY_PERSISTENT_DIR="/data/sidecar/eufy_data"
    
    echo "[DEBUG] [Bash] Extracted EUFY_USERNAME: '${EUFY_USERNAME}'"
    echo "[DEBUG] [Bash] Extracted MQTT_HOST: '${MQTT_HOST}'"
    
    if [ -z "$EUFY_USERNAME" ] || [ "$EUFY_USERNAME" == "null" ]; then
        echo "[ERROR] Eufy Username is not set in Home Assistant configuration."
        exit 1
    fi
else
    echo "[WARNING] options.json not found. Assuming local testing environment with pre-set variables."
fi

# 2. Zorg dat de data mappen bestaan
mkdir -p /data/sidecar
mkdir -p /data/sidecar/eufy_data

# 3. Start de C++ Orchestrator
echo "[INFO] Handing over control to C++ Sidecar Orchestrator."
exec /app/build/Wols_CA_HA_Eufy