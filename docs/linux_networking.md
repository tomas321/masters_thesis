# Practical aspects of Linux interface configurations

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
`brctl addr mybr0`

Associate the physical NIC of the host to this bridge:
`brctl addif mybr0 eno1`
*Note that this will remove all configured IP addresses on `eno1`.*

Set the bridge device up/down:
`ip link set dev mybr0 up`

Optionally delete the bridge with:
`brctl delbr mybr0`

With this setting the bridge interface is set up and ready to be used by the VM.

[source link](https://cloudbuilder.in/blogs/2013/12/02/linux-bridge-virtual-networking/)
