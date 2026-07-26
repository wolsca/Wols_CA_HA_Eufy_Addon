#!/bin/bash

# Extract the current version from the local config.yaml
APP_VERSION=$(grep '^version:' /app/config.yaml | cut -d '"' -f 2)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo ""
echo "================================================================="
echo "[$TIMESTAMP] Wols CA C++ Backend v$APP_VERSION - INITIALIZING STARTUP SEQUENCE"
echo "================================================================="

# Extract user configuration from Home Assistant Add-on /data/options.json using jq
export EUFY_USER=$(jq -r '.EUFY_USER' /data/options.json)
export EUFY_PASS=$(jq -r '.EUFY_PASS' /data/options.json)
export EUFY_STATION_SN=$(jq -r '.EUFY_STATION_SN' /data/options.json)
export HA_ACCESS_TOKEN=$(jq -r '.HA_ACCESS_TOKEN' /data/options.json)
export MQTT_HOST=$(jq -r '.MQTT_HOST' /data/options.json)
export MQTT_PORT=$(jq -r '.MQTT_PORT' /data/options.json)
export MQTT_USER=$(jq -r '.MQTT_USER' /data/options.json)
export MQTT_PASS=$(jq -r '.MQTT_PASS' /data/options.json)

echo "[$TIMESTAMP] Configuration loaded successfully. Handing over to C++ binary..."
echo "================================================================="

# Execute the compiled binary
/app/build/Wols_CA_HA_Eufy