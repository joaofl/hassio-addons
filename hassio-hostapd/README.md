# hassio-hotspot (previously hassio-hostapd-extended)
Enables an access point using USB Wifi dongle for your IoT devies on Home Assistant (with embedded DHCP server). This is mostly usefull if you want to have a different network infrastructure for your IoT devices, and can not do it with the RPi onboard Wifi, due to stabilities issue. 

It allows creating an access point **with optional a DHCP server**, to your IoT devices using extenral USB Wifi dongles, **Ralink, Atheros and others**. It began a fork of the hostapd addon, that I rebranded, given that it now does more than that: it adds DHCP server with selectable internet access to the devices on the hotspot. It also adds supports to external USB dongles in order to enable a stable access points, known that the onboard Broadcomm Wifi on the RPi has unstable operation and does not provide the reliability required.

## Installation

To use this repository with your own Hass.io installation please follow [the official instructions](https://www.home-assistant.io/hassio installing_third_party_addons/) on the Home Assistant website with the following URL:

```txt
https://github.com/joaofl/hassio-addons
```

### Configuration

The available configuration options are as bellow. Make sure to edit
according to your needs:

```
{
    "ssid": "WIFI_NAME",
    "wpa_passphrase": "WIFI_PASSWORD",
    "channel": "0",
    "address": "192.168.2.1",
    "netmask": "255.255.255.0",
    "broadcast": "192.168.2.254"
    "interface": ""
    "allow_internet": false
    "dhcp_server": true
    "dhcp_start": "192.168.2.100",
    "dhcp_end": "192.168.2.200",
    "dhcp_dns": "1.1.1.1",
    "dhcp_subnet": "255.255.255.0",
    "dhcp_router": "192.168.2.1",
    "hide_ssid": false
}

```
When channel set to 0, it will automatically find the best channel. 

When the `interface` option is left blank, a list with the detected wlan
interfaces will be printed on the logs and the addon will terminate. Set
the correct `interface` value on the configuration then restart the addon.
