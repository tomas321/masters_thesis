# Practical aspects of Linux interface configurations

useful links:
[Introduction to Linux interfaces for virtual networking](https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking/)

All interface properties are located in `/sys/class/net/<iface>` directory.

## NIC bonding

Bonding is the aggregation or combination of multiple NIC into a single bond interface. May advatages and purposes are redundancy and link aggregation

#### Usage

Use the ansible [role](https://github.com/tomas321/ansible-config-interfaces.git) to configure network interfaces or manual configuration example bonding `wlo1` and `eno1`:
```bash
root# cat /etc/network/interfaces
...
# Define slaves
auto eno1
iface eno1 inet manual
    bond-master bond0
    bond-primary eno1
    bond-mode active-backup

auto wlo1
iface wlo1 inet manual
    wpa-conf /etc/network/wpa.conf
    bond-master bond0
    bond-primary eno1
    bond-mode active-backup

# Define master
auto bond0
iface bond0 inet dhcp
    bond-slaves none
    bond-primary eno1
    bond-mode active-backup
    bond-miimon 100
...
```

[link source](https://www.interserver.net/tips/kb/network-bonding-types-network-bonding/)

## Network bridge

[Bridge](https://wiki.archlinux.org/index.php/Network_bridge) is a software as kernel module used to connect to network segments. It behaves as a simple virtual switch connecting both real (e.g. eno1) and virtual (e.g. tap0) devices.

Other use case is to bridge to physical/virtual interfaces, such as prividing connectivity to a VM via a physical interface of the host.

#### Usage

Create a bridge interface:
`brctl addr mybr0` or `ip link add name mybr0 type bridge`

Associate the physical NIC of the host to this bridge:
`brctl addif mybr0 eno1` or `ip link set dev eno1 master mybr0`
*Note that this will remove all configured IP addresses on `eno1`.*

enslaving a WIFI interface to a bridge requires additional step:
`iw dev wlo1 set 4addr on` - sets the WDS mode (not tested to work)

Set the bridge device up/down:
`ip link set dev mybr0 up`

Optionally delete the bridge with:
`brctl delbr mybr0` or `ip link del dev mybr0`

With this setting the bridge interface is set up and ready to be used by the VM. It is dependent of setting a master to the physical interface to enable Internet connection. [source](https://cloudbuilder.in/blogs/2013/12/02/linux-bridge-virtual-networking/)

When the libvirt default network is running, you will see an isolated bridge device. This device explicitly does *NOT* have any physical interfaces added, since it uses NAT + forwarding to connect to outside world. Do not add interfaces. Libvirt will add iptables rules to allow traffic to/from guests attached to the virbr0 device in the INPUT, FORWARD, OUTPUT and POSTROUTING chains. It will also attempt to enable ip\_forward. Some other applications may disable it, so the best option is to add the following to `/etc/sysctl.conf`. [source](https://wiki.libvirt.org/page/Networking)

To simulate the NAT + forwarding setup the iptables rules:
```
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:domain
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootps
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:bootps

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination
ACCEPT     all  --  anywhere             192.168.122.0/24     ctstate RELATED,ESTABLISHED
ACCEPT     all  --  192.168.122.0/24     anywhere
ACCEPT     all  --  anywhere             anywhere
REJECT     all  --  anywhere             anywhere             reject-with icmp-port-unreachable
REJECT     all  --  anywhere             anywhere             reject-with icmp-port-unreachable

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootpc
```

##### simulating additional libvirt interfaces

create dummy interface with bridge MAC (works without it too):
```
ip link add name mybr0-nic type dummy
ip link set mybr0-nic address <MAC_addr>
ip link set mybr0-nic master mybr0
```
