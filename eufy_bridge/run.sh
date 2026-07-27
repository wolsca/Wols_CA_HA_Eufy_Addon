#!/usr/bin/env bash
set -e

echo "[INFO] Wols CA Eufy HA Bridge is initializing..."

# 1. Lees configuratie uit Home Assistant in
CONFIG_PATH=/data/options.json

if [ -f "$CONFIG_PATH" ]; then
    echo "[INFO] Loading configuration from Home Assistant..."
    
    export EUFY_USERNAME=$(jq --raw-output '.username // empty' $CONFIG_PATH)
    export EUFY_PASSWORD=$(jq --raw-output '.password // empty' $CONFIG_PATH)
    export EUFY_COUNTRY=$(jq --raw-output '.country // "NL"' $CONFIG_PATH)
    export EUFY_PERSISTENT_DIR="/data/sidecar/eufy_data"
    
    # Extra logging om te verifiëren wat jq uit het HA bestand trekt
    echo "[DEBUG] [Bash] Extracted EUFY_USERNAME: '${EUFY_USERNAME}'"
    echo "[DEBUG] [Bash] Extracted EUFY_COUNTRY: '${EUFY_COUNTRY}'"
    
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