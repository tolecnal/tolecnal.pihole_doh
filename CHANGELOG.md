# Changelog

## 2026-02-26

Version: 2.1.0

### Pi-hole 6 compatibility
- Replaced deprecated `FTLCONF_LOCAL_IPV4` env var with `FTLCONF_dns_reply_host_IPv4`
- Replaced `PIHOLE_DNS_` env var with `FTLCONF_dns_upstreams` (Pi-hole 6 FTL config)
- Added `FTLCONF_webserver_api_password` alongside `WEBPASSWORD` for Pi-hole 6 API auth
- Added `SYS_NICE` capability to the Pi-hole container to suppress process priority warning
- Replaced sqlite3-based adlist management with the Pi-hole 6 REST API; custom lists are now added via `docker_pihole_custom_lists` and checked for reachability before submission
- Switched all Pi-hole API calls to `ansible.builtin.command` with `argv:` to avoid shell quoting issues

### dnscrypt-proxy
- Added `dnscrypt_listen_address` variable (default: `0.0.0.0`) to control the bind address on port 5300
- Switched from socket activation to a direct systemd service to eliminate boot-time port conflicts
- Deployed a standalone service unit at `/etc/systemd/system/dnscrypt-proxy.service` to remove the implicit socket dependency in the package's unit file
- `dnscrypt-proxy.socket` is now stopped, disabled, and masked to prevent it reclaiming port 53
- Fixed `/var/cache/dnscrypt-proxy` and `/var/log/dnscrypt-proxy` directory ownership

### Cleanup
- Removed `kwoodson.yedit` dependency (network configuration uses the `yq` CLI directly)
- Removed unused `docker_pihole_adlist` variable (leftover from sqlite3 era)

## 2026-02-24

Version: 2.0.0

- Replaced Cloudflare DNS proxy (cloudflared) with dnscrypt-proxy for encrypted DNS
- dnscrypt-proxy is installed from the distribution's native package repository
- dnscrypt-proxy is configured to listen on the host's primary network interface IP on port 5300
- Pi-hole is configured to use dnscrypt-proxy as its upstream DNS resolver
- Dropped support for Ubuntu 20.04 (focal), 22.04 (jammy), Debian 11 (bullseye), and Debian 12 (bookworm)
- Role now requires Ubuntu 24 (noble) or higher, or Debian 13 (trixie) or higher
- Added OS version assertion that fails early on unsupported platforms

## 2024-10-08

Version: 1.0.6

Initial release as a role.
