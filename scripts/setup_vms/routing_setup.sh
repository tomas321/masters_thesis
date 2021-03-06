#!/bin/bash
#
# run as root!
# The script is a temporary fix to missing settings on the target VM.
# Must be ran LOCALLY ON the target system
#
# usage: $0 ROUTE_NET ROUTE_GATEWAY ROUTE_IFACE
#

usage="usage: $0 ROUTE_NET ROUTE_GATEWAY ROUTE_IFACE"

if [[ $# -lt 3 ]]; then
    echo "error: missing argument"; echo -e "\n$usage"; exit 1
fi

net="$1"
via_ip="$2"
iface="$3"

# necessary sysctl setting
# rp_filter = its adviced to be enabled. since it is, there is a problem in case of
# multiple interfaces on the VM. If a connection or ping comes from different interface
# that the VM would otherwise route the packet (reverse-path) - it would be ignored/dropped.
# Therefore a route needs to be added to ensure the packet is reverse routed via the
# same interface not via the default route interface for example.
#
# The ip_forward should already be set, this is only a precaution
for entry in "net.ipv4.conf.all.rp_filter=1" "net.ipv4.ip_forward=1"; do
    sysctl -w "$entry"
done

sysctl -p

# add the reverse-path accroding route. Most important!!!
ip route add $net via $via_ip dev $iface

# OTHER possiblity is to disable the RP_FILTER.. but we dont what that
