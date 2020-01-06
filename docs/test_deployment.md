# Kubernetes deployment

minimum number of nodes: 3 nodes
- 1 mater node
    - `m1.k8s.dev.local`
- 2 worker nodes
    - `n1.k8s.dev.local`
    - `n2.k8s.dev.local`

1. Setup a vagrant deployment from a minimal base image
2. Via [kubespray](https://kubespray.io/#/) setup the k8s cluster

## node machine

I have 3 kubernetes nodes as local KVMs. For node provisioning I used an Ansible playbook - `my-skeleton/playbooks/tomas/linux-server.yml` to setup ssh, ntp and other normalizations.
Each node must have a separate storage pool.

### specification

specified machine below is the base of each node, including the provisioning.

| component | value         |
| --------- | ------------- |
| OS        | Ubuntu bionic |
| RAM       | 4 GB          |
| storage   | 10 GB         |
| CPUS      | 1-2           |
| vCPUS     | 8             |

install command:
```bash
virt-install --virt-type kvm --name node.kub.local --memory 8192 --cdrom ubuntu-bionic.iso --disk size=10,path=/a/b/c.qcow2 --os-variant ubuntu18.04 --cpu host --vcpus cpuset=1-2,maxvcpus=8
```

## test deployment

The test deployment of 3 VMs is included in the [test Vagrantfile](../vagrant_test/Vagrantfile)

### networking
Simple communication bridge isolated from the outside networks:
```bash
ip link add name mybr0 type bridge
ip add add 10.0.0.1/24 dev mybr0
ip link set dev mybr0 up
```

## deployment

### Networks

`vagrant-mgmt` - the vagrant management network in libvirt
`mybr0` - isolated inter-node bridge

### IPs

`m1.k8s.dev.local` - 10.0.0.10/24
`n1.k8s.dev.local` - 10.0.0.20/24
`n2.k8s.dev.local` - 10.0.0.21/24

### Vagrant

All is configured in the [k8s Vagrantfile](../vagrant_k8s/Vagrantfile), except the network bridge
