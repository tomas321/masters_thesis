# Kubernetes deployment

- 3 nodes
    - 1 mater node
        - `m1.k8s.dev.local`
    - 2 worker nodes
        - `n1.k8s.dev.local`
        - `n2.k8s.dev.local`

## node machine

I have 3 kubernetes nodes as local KVMs. For node provisioning I used an Ansible playbook - `my-skeleton/playbooks/tomas/linux-server.yml` to setup ssh, ntp and other normalizations.

### specification

specified machine below is the base of each node, including the provisioning.

| component | value         |
| --------- | ------------- |
| OS        | Ubuntu bionic |
| RAM       | 8 GB          |
| storage   | 10 GB         |
| CPUS      | 1-2           |
| vCPUS     | 8             |

install command:
```bash
virt-install --virt-type kvm --name node.kub.local --memory 8192 --cdrom ubuntu-bionic.iso --disk size=10,path=/a/b/c.qcow2 --os-variant ubuntu18.04 --cpu host --vcpus cpuset=1-2,maxvcpus=8
```

### networking
