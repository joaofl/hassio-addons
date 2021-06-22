# Changelog

## [1.1.1]
### Changed
- Add possibility to show or hide the SSID

## [1.1.0]
### Changed
- Add possibility to configure the DHCP and Hosapd settings for better customization of the access point
- Fix issue with enablind/disabling internet access not working before


## [1.0.11.5]
### Changed
- Removed the external DHCP addon from this repo

### Added
- Support for Atheros based Wifi dongles
- Settings to enable/disable internet access on the hotspot
- Settings to enable/disable a DHCP server on the hotspot

## [1.0.10]
### Changed
- Removed other addons from this repo
- Removed package versions from setup, to avoid new installs problem

### Added
- Possibility of setting the access point with USB Wifi dongles.

## [1.0.4 -> 1.0.9]
### Changed
- Versions used internally only, during development

## [1.0.3] -> This fork
### Fixed
- Update apk networkmanager and sudo in Dockefile. 

## [1.0.2]
### Fixed
- Disabled NetworkManager for wlan0 to prevent the addon stop working after a few minutes. 

## [1.0.1]
### Fixed
- Gracefully Stopping Docker Containers 

### Changed
- Apply Changelog Best Practices


## [1.0.0]
- Initial version