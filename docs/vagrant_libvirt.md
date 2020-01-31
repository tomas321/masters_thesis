# vagrant-libvirt configuration

## private network
- creates new network managed by libvirt
- creates a corresponding interface in the domain configuration file
- provides numerous options
- this network is isolated and does not forward traffic

```ruby
config.vm.define :test_vm1 do |test_vm1|
    test_vm1.vm.network :private_network,
        :type => "dhcp",
        :libvirt__network_address => '10.20.30.0'
end
```
- this configures a new privte network including DHCP

## public network
- creates an interface in the domain configuration file
- connects to the specified device (network bridge)

```ruby
config.vm.define :test_vm1 do |test_vm1|
    test_vm1.vm.network :public_network,
        :dev => "mybr0",
        :mode => "bridge",
        :type => "bridge",
        :ip => "10.0.0.5"
end
```
- this configures a new interface with an IP address connected to `mybr0`

## management network
- it's the vagrant management network providing traffic forwarding (i.e. to the Internet)
- can be reconfigured with various options

## for configuring testing networks

```ruby
machine.vm.network :private_network,
    :libvirt__network_name => "test_network",
    :libvirt__netmask => "255.255.0.0",
    :libvirt__forward_mode => "none",
    :libvirt__dhcp_enabled => false,
    :libvirt__host_ip => "10.10.0.1",
    :ip => "10.10.0.2"
```

- configures a private network `test_network` for a `machine`
- it is the equivalent to creating a bridge interface on the host
- host network is set to `10.10.0.0/16`
- `machine` IP address is set to `10.10.0.2`

## default management network 'vagrant-libvirt'

It is the management network enable availability of the VMs for vagrant. The management network allows limited modification (e.g. network address, network name, mac address ...). It lacks using an existing network bridge in stead. Although, the usage of already existing bridges is allowed with the usage of the `qemu-bridge-helper` tool.

The `qemu-bridge-helper`:
- needs to be configured for a regular user
- enables bridged networking for unprivileged virtual machines
- works only for user session `qemu_user_session = true`

### solution

Using vagrant is managament-network-dependent.

In addition set up an IP address to newly created interface on the machine connected to an existing network bridge `mybr0`:
```ruby
master1.vm.network :public_network,
    :dev => "mybr0",
    :mode => "bridge",
    :type => "bridge",
    :ip => "10.0.0.5"
```
