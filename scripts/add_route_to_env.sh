#!/bin/bash
#
# add ip route to a given network
#
# usage: $0  DESTIONATION_NETWORK  VIA_IP  INTERFACE
#

usage="
  usage: $0  DESTIONATION_NETWORK HOP_GW_IP INTERFACE"

if [[ $# -ge 3 ]]; then
    destination_net="$1"
    via_ip="$2"
    iface="$3"
elif [[ $# -lt 3 ]]; then
    echo -e "error: bad number of arguments: $*\n$usage" && exit 1
fi

echo "running: 'ip route show to match ${destination_net%/*}'"
ip route show to match ${destination_net%/*} | grep "dev $iface " | grep "via $via_ip " && echo "route is already satisfied OR a conflicting route exists" && exit 0

# route is missing -> configure
echo "setting up route..."
sudo ip route add "$destination_net" via "$via_ip" dev "$iface"

exit 0
