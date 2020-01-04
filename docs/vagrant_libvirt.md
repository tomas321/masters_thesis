# vagrant-libvirt configuration

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

- disabling the network so far unresolved - TODO
