#!/bin/bash

echo "Starting Wols CA C++ Backend..."

# Extract user configuration from Home Assistant Add-on /data/options.json using jq
export EUFY_USER=$(jq -r '.EUFY_USER' /data/options.json)
export EUFY_PASS=$(jq -r '.EUFY_PASS' /data/options.json)
export EUFY_STATION_SN=$(jq -r '.EUFY_STATION_SN' /data/options.json)
export HA_ACCESS_TOKEN=$(jq -r '.HA_ACCESS_TOKEN' /data/options.json)

# Execute the compiled binary
/app/build/Wols_CA_HA_Eufy