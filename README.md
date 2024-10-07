# ansible-role-pihole-doh

Deploy and configure Pihole DNS Docker image which uses Cloudflare's DNS service over HTTPS

## Requirements

Role will install the following Ansible roles:

- geerlingguy.docker
- kwoodson.yedit

## Role variables

Available variables are listed below, along with the default values (see: `defaults/main.yml`)

---

    docker_pihole_container_name: pihole

Name of the Docker container.

    docker_pihole_image_name: pihole/pihole:latest

Name of the Docker image to pull.

    docker_pihole_network: bridge

Which Docker network type to use.

    docker_pihole_network_interface: "eth0"

Which network that Pihole will use.

    docker_pihole_enable_ipv6: false

Enable support for IPv6?

    docker_pihole_enable_dnssec: false

Enable support for DNSSEC?

    docker_pihole_admin_port: 8053

Which port the Pihole Admin Interface will bind to.

    docker_pihole_host_dir_dnsmasqd: home/docker/pihole/etc/dnsmasq.d/

Path to the dnsmasq volume.

    docker_pihole_host_dir_pihole: /home/docker/pihole/etc/pihole/

Path to the Pihole config volume.

    docker_pihole_adlist: "{{ docker_pihole_host_dir_pihole }}adlists.list"

Path and name for the `adlists.list` file.

    docker_pihole_volumes:
      - "{{ docker_pihole_host_dir_pihole }}:/etc/pihole/"
      - "{{ docker_pihole_host_dir_dnsmasqd }}:/etc/dnsmasq.d/"

Mapping for the Pihole volumes.

    docker_pihole_timezone: "Europe/London"

Timezone that Pihole will use.

    docker_pihole_dns_servers:
      - "1.1.1.1"

DNS server that Pihole will use

    docker_pihole_rev_server: false

Whether or not Pihole will use a conditional forward for a domain.

    docker_pihole_rev_server_domain: example.com

The domain to use conditional forwarding for.

    docker_pihole_rev_server_target: 192.168.1.1

The IP address to the DNS server that serves request for the conditional forward.

    docker_pihole_rev_server_cidr: 192.168.1.0/24

The CIDR notation for the network that the conditional forward will apply to.

    docker_pihole_custom_lists: []

List of URLs to public blacklists that Pihole will use.

## Dependencies

None

## Example playbook

First install the role using Ansible Galaxy: `ansible-galaxy role install tolecnal.pihole_doh`.

Then create a file called `passwords.yml` which contains the password `web_pass`. I of course recommend using Ansible vault to create and store your secrets.

Then create a playbook like this.

    ---

    - name: Setup and configure pihole with DoH
    hosts: localhost
    become: true
    gather_facts: true

    vars_files:
        - passwords.yml

    vars:
        docker_pihole_timezone: "CEST"
        docker_pihole_enable_dnssec: true
        docker_pihole_custom_lists:
          - https://v.firebog.net/hosts/AdguardDNS.txt
          - https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt
          - https://v.firebog.net/hosts/RPiList-Malware.txt
        docker_pihole_rev_server: true
        docker_pihole_rev_server_domain: xiro.net
        docker_pihole_rev_server_target: "192.168.127.1"
        docker_pihole_rev_server_cidr: "192.168.126.0/23"

    roles:
        - tolecnal.pihole_doh

## License

MIT / BSD

## Author information

Jostein Elvaker Haande - tolecnal - [tolecnal.net](https://tolecnal.net)
