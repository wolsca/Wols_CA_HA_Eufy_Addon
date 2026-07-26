#!/usr/bin/with-contenv bashio

# Extract user configuration from Home Assistant Add-on UI
export EUFY_USER=$(bashio::config 'EUFY_USER')
export EUFY_PASS=$(bashio::config 'EUFY_PASS')
export EUFY_STATION_SN=$(bashio::config 'EUFY_STATION_SN')
export HA_ACCESS_TOKEN=$(bashio::config 'HA_ACCESS_TOKEN')

bashio::log.info "Starting Wols CA C++ Backend..."

# Execute the compiled binary
/app/build/Wols_CA_HA_Eufy