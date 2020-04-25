#!/bin/bash

# SIGTERM-handler this funciton will be executed when the container receives the SIGTERM signal (when stopping)
reset_interfaces(){
    ifdown $INTERFACE
    sleep 1
    ip link set $INTERFACE down
    ip addr flush dev $INTERFACE
}

term_handler(){
    echo "Resseting interfaces"
    reset_interfaces
    echo "Stopping..."
    exit 0
}

# Setup signal handlers
trap 'term_handler' SIGTERM

echo "Starting..."

CONFIG_PATH=/data/options.json

SSID=$(jq --raw-output ".ssid" $CONFIG_PATH)
WPA_PASSPHRASE=$(jq --raw-output ".wpa_passphrase" $CONFIG_PATH)
CHANNEL=$(jq --raw-output ".channel" $CONFIG_PATH)
ADDRESS=$(jq --raw-output ".address" $CONFIG_PATH)
NETMASK=$(jq --raw-output ".netmask" $CONFIG_PATH)
BROADCAST=$(jq --raw-output ".broadcast" $CONFIG_PATH)
INTERFACE=$(jq --raw-output ".interface" $CONFIG_PATH)

# Enforces required env variables
required_vars=(SSID WPA_PASSPHRASE CHANNEL ADDRESS NETMASK BROADCAST)
for required_var in "${required_vars[@]}"; do
    if [[ -z ${!required_var} ]]; then
        echo >&2 "Error: $required_var env variable not set."
        exit 1
    fi
done


INTERFACES_AVAILABLE="$(ifconfig -a | grep wl | cut -d ' ' -f '1')"
UNKNOWN=true

if [[ -z $INTERFACE ]]; then
        echo >&2 "Network interface not set. Please set one of the available:"
        echo "$INTERFACES_AVAILABLE"
        exit 1
fi

for OPTION in  ${INTERFACES_AVAILABLE}; do
    if [[ ${INTERFACE} == ${OPTION} ]]; then
        UNKNOWN=false
    fi 
done

if [[ $UNKNOWN == true ]]; then
        echo >&2 "Unknown network interface ${INTERFACE}. Please set one of the available:"
        echo "$INTERFACES_AVAILABLE"
        exit 1
fi


reset_interfaces

echo "Set nmcli managed no"
nmcli dev set $INTERFACE managed no

echo >&2 "Network interface ${INTERFACE} set"



# Setup hostapd.conf
echo "Setup hostapd ..."
echo "ssid=${SSID}"$'\n' >> /hostapd.conf
echo "wpa_passphrase=${WPA_PASSPHRASE}"$'\n' >> /hostapd.conf
echo "channel=${CHANNEL}"$'\n' >> /hostapd.conf
echo "interface=${INTERFACE}"$'\n' >> /hostapd.conf


# Setup interface
echo "Setup interface ..."

IFFILE=/etc/network/interfaces

echo -n "" > ${IFFILE}
echo "iface ${INTERFACE} inet static" >> ${IFFILE}
echo "   address ${ADDRESS}" >> ${IFFILE}
echo "   netmask ${NETMASK}" >> ${IFFILE}
echo "   broadcast ${BROADCAST}" >> ${IFFILE}

ifdown $INTERFACE
sleep 1
ifup $INTERFACE

echo "Starting HostAP daemon ..."
hostapd -d /hostapd.conf & wait ${!}