# hassio-hotspot (previously hassio-hostapd-extended)
Enables an access point using USB WiFi dongle (or onboard) for your IoT devies on Home Assistant (with embedded DHCP server). USB WiFi is mostly useful if you want to have a different network infrastructure for your IoT devices, and the RPI onboard WiFi is not available or is unstable.

It allows creating an access point **with optional a DHCP server**, to your IoT devices using external USB WiFi dongles, **Ralink, Atheros and others**. It began a fork of the hostapd addon, that I renamed, given that it now does more than that: it adds DHCP server with selectable internet access to the devices on the hotspot. It also adds supports to external USB dongles in order to enable a stable access points, known that the onboard Broadcomm WiFi on the RPI has unstable operation and does not provide the reliability required.

## Installation

To use this repository with your own Hass.io installation please follow [the official instructions](https://www.home-assistant.io/hassio installing_third_party_addons/) on the Home Assistant website with the following URL:

```txt
https://github.com/joaofl/hassio-addons
```

### Configuration

The available configuration options are as bellow. Make sure to edit
according to your needs:

```json
{
    "ssid": "WIFI_NAME",
    "wpa_passphrase": "WIFI_PASSWORD",
    "channel": "0",
    "address": "192.168.2.1",
    "netmask": "255.255.255.0",
    "broadcast": "192.168.2.254"
    "interface": ""
    "interface_internet": "eth0"
    "allow_internet": false
    "dhcp_server": true
    "dhcp_start": "192.168.2.100",
    "dhcp_end": "192.168.2.200",
    "dhcp_dns": "1.1.1.1",
    "dhcp_subnet": "255.255.255.0",
    "dhcp_router": "192.168.2.1",
    "hide_ssid": false,
    "lease_time": 864000,
    "static_leases": [
        {
            "mac": "00:11:22:33:44:55",
            "ip": "192.168.2.10",
            "name": "Living Room Light"
        }
    ]
}
```

When channel set to 0, it will automatically find the best channel. 

When the `interface` option is left blank, a list with the detected wlan
interfaces will be printed on the logs and the addon will terminate. Set
the correct `interface` value on the configuration then restart the addon.

### DHCP Configuration

#### Lease Time
The `lease_time` option sets how long (in seconds) a DHCP-assigned IP address remains valid. Default is 864000 seconds (10 days).

#### Static Leases
When configuring static leases, ensure the IP addresses are outside your DHCP range (defined by `dhcp_start` and `dhcp_end`) to avoid IP conflicts.

Example: If your DHCP range is 192.168.2.100 to 192.168.2.200, your static IPs should be below .100 or above .200.

The `static_leases` option allows you to:
- Reserve specific IP addresses for devices based on their MAC address
- Optionally assign friendly names to devices for identification
- Ensure devices always get the same IP address

Each static lease entry requires:
- `mac`: The device's MAC address (format: XX:XX:XX:XX:XX:XX)
- `ip`: The IP address to assign
- `name`: (Optional) A friendly name to identify the device
