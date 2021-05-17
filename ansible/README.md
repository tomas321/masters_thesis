# Playbooks reference

Briefly described playbooks with possible prerequisites/dependencies and mainly their use cases.

## Setup playbooks (pre-kubernetes)

These playbooks are self-sustainable and used for pre-kubernetes setups (e.g. VMs, net bridge, latex, tooling)

### [bcc.yml](playbooks/bcc.yml)

Installs bpftool for current kernel version and [bcc](https://github.com/iovisor/bcc) tools from source

**Reruires**:
- bpftool (from package linux-tools-common) version is based on kernel version, therefore `linux-generic-hwe-18.04` (for Ubuntu 18.04) or Ubuntu 20.04 or higher


### [bridge-networking.yml](playbooks/bridge-networking.yml)

WIP

### [kvm-networks.yml](playbooks/kvm-networks.yml)

WIP

### [latex.yml](playbooks/latex.yml)

Setup Latex with additional packages.

### [setup_kvm.yml](playbooks/setup_kvm.yml)

Installs KVM and its dependencies with a specific storage pool.

### [simple_bridge.yml](playbooks/simple_bridge.yml)

Create a simple network bridge using ifupdaown.

### [vagrant_k8s_down.yml](playbooks/vagrant_k8s_down.yml)

Removes the inter-node network bridge and calls `vagrant halt` on [Vagrantfile](../provisioner/vagrant/Vagrantfile)

### [vagrant_k8s_up.yml](playbooks/vagrant_k8s_up.yml)

Setups the inter-node network bridge and calls `vagrant up` on [Vagrantfile](../provisioner/vagrant/Vagrantfile).

**Requires**:
- SSH key pair in `playbooks/files/.ssh/id_vagrant_k8s.pub` `playbooks/files/.ssh/id_vagrant_k8s`

## Kubernetes playbooks

Functional and running Kubernetes cluster is a prerequisite for these playbooks

### [sneakpeek.yml](playbooks/sneakpeek.yml)

Copies the templated execsnoop/tcptracer caller script and setups a template systemd unit file on each k8s worker node. Additionally the unit file redirects the stdout and stderr to a configured logfile. This unit file may be used to start the execsnoop/tcptracer service for monitoring a container as so:
- given that the unit file is named `execsnoop@.service`
- regarding the bcc tool `--mntnsmap` option which should be e.g. `/sys/fs/bpf/mysql_docker_mntnsmap`
- start a service with `systemctl start execsnoop@mysql_docker_mntnsmap`
    - the service executes a [caller script](roles/sneakpeek/templates/execsnoop/caller.sh.j2) and starts a process monitor

- start a service with `systemctl start tcptracer@mysql_docker_mntnsmap`
    - the service executes a [caller script](roles/sneakpeek/templates/tcptracer/caller.sh.j2) and starts a process monitor

### [sneakctl_server.yml](playbooks/sneakctl_server.yml)

Downloads and installs the python project [sneakctl_server](https://github.com/tomas321/sneakctl_server/) on each k8s worker node. Additionally, starts the API server as a systemd service.

### [fswatch.yml](playbooks/fswatch.yml)

Deploys the fswatch tool and copies template systemd unit file `fswatch@.service`. Additionally the unit file redirects the stdout and stderr to a configured logfile. This unit file may be used to start the fswatch service for monitoring a container as so:
- start a service with e.g. `systemctl start execsnoop@1234567890`, where the number is a container ID and can also be the full container name
    - the service executes a [caller script](roles/fswatch/templates/fswatch_caller.sh.j2), which uses the conatainer ID to retrieve the root container directory.

### [kubectl.yml](playbooks/kubectl.yml)

Downloads the `kubectl` tool and configures auto-complete.

**Usage**:
- `ansible-playbook playbooks/kubectl.yml -l localhost` - the **-l** option is important since the playbook executes by default on all hosts.

### [prometheus.yml](playbooks/prometheus.yml)

Configure prometheus golden metrics monitoring. Creates all k8s objects using the helm (k8s package manager-like installer).

**Requires**:
- `helm`

### [metallb.yml](playbooks/metallb.yml)

Configures the MetalLB load balancer in Kubernetes with a address pool for future Services of type LoadBalancer.

**Requires**:
- `kubectl`, which can be seamlessly installed using the [kubectl.yml](playbooks/kubectl.yml) playbook.

### [nfs.yml](playbooks/nfs.yml)

Setup the NFS provisioner objects and install and configure the NFS server on the data node.

### [nfs_delete_objects.yml](playbooks/nfs_delete_objects.yml)

Delete the NFS provisioner k8s objects.
