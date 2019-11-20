# KVM essentials

## Networking

All KVM networking is well documented on the official [wiki](https://libvirt.org/docs.html) in the XML format sections for [domain interfaces](https://libvirt.org/formatdomain.html) and [host networks](https://libvirt.org/formatnetwork.html).

In addition, the networking concepts are summarized in [my gist](https://gist.github.com/tomas321) for KVM networking.

## Storage pools

- Directory pool
    - accomodates libvirt images in a directory
- Filesystem pool
- Network filesystem pool
- Logical volume pool
- Disk pool
- iSCSI pool
- iSCSI direct pool
- SCSI pool
- Multipath pool
- RBD pool
- Sheepdog pool
- Gluster pool
- ZFS pool
- Vstorage pool


## Ansible roles

### ROLE ansible-kvm

Sets up libvirt and kvm on target host.
configures:
- `storage_pools`
- `virtual_networks`
- `virtual machines`

### ROLE ansible-config-interfaces

For Debian OS family it configures network in the `/etc/network/interfaces` file, which is managed by the `ifupdown` tool.

Variable `config_network_interfaces` is a master boolean variable according to which the any interfaces/bonds/bridges/vlans are configured.

#### Linux networking

configures:
- `bonds`
    - bonds two existing interfaces to create "network bond" used for load balancing and redundancy
- `bridges`
    - acts as a virtual/software switches, which allows it to have multiple ports defined as interface names
    - bridge ports must be existing interfaces
- `interfaces`
    - interfaces with IP configuration, DHCP and custom parameters
    - methods used:
        - `manual` - the interface is configured manually using ip command
        - `static` - the interface has a static IP address
        - `dhcp` - dynamic IP address is requested via DHCP
    - interfaces, that act as bond slaves require extra parameter (`bond_master <bond_name>`)
- `vlans`
    - Linux way of configuring vlans
    - attaches a raw vlan device (one of the existing interfaces)


#### OpenVSwitch:

configures:
- `bonds`
    - bonds that are connected to a ovs bridge
    - bonds two existing linux interfaces
- `bridges`
    - acts as a virtual/software switches, which allows it to have multiple ports defined as interface names
    - bridge ports must be existing ovs interfaces
- `interfaces`
    - ovs specific interfaces, that belong to given ovs bridge
    - may include vlan configuration and IP address


### ROLE ansible-openvswitch

<!-- TODO -->
