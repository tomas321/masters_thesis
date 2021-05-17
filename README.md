# Master thesis
## Bait network based monitoring of malicious actors

### Assignment
Read the [english](./docs/initial_research/mt_assignment.md) or [slovak](./docs/initial_research/dp_text_zadania.md) assignment of my thesis.

The initial research overview [Latex document](./docs/initial_research/latex) required by the university, summarizes summarizes the motivation and important aspects of the thesis.

### Documentation links

#### [KVM essentials](./docs/kvm_essentials.md)

This page sums up the KVM configurations from its wiki and Ansible roles for networking and libvirt/kvm setup.

#### [Linux networking](./docs/linux_networking.md)

Linux networking main aspects and its correlation with libvirt networking.

#### [Vagrant basics](./docs/vagrant.md)

Includes the most important parts of vagrant and it connection with libvirt.

This repository inlcludes Vagrant files various deployments of multiple libvirt-managed VMs.

#### [Test deployment](./docs/test_deployment.md)

This documents the test deployment for k8s and the applied networking.

#### [Kubernetes fundamentals](./docs/kubernetes.md)

k8s fundamentals gathered so far from the official documentation

#### [Existing solutions](./docs/existing_solutions.md)

Research of related work and existing solution on the market.

Additionally includes collected knowledge and design ideas.

### Prerequisites
**ansible** - `sudo pip3 install ansible`
### Setup and installation

For ansible playbooks documentation refer to the dedicated [README.md](./ansible/README.md)

1. Clone the repository.
    - `git clone https://github.com/tomas321/masters_thesis`

2. Setup a ssh key pair for accessing the nodes.
    - `ssh-keygen -t rsa -N <your_passphrase> -f ansible/playbooks/files/.ssh/id_vagrant_k8s` - generate simple key pair

3. Run the Ansible [setup kvm playbook](./ansible/playbooks/setup_kvm.yml) as root.
    - ```bash
      cd masters_thesis/ansible
      ansible-playbook -K -i inventory/prod/hosts playbooks/setup_kvm.yml
      ```

4. Run the Ansible [vagrant k8s up playbook](./ansible/playbooks/vagrant_k8s_kvm.yml) as root.
    - ```ansible-playbook -K -i inventory/prod/hosts playbooks/vagrant_k8s_up.yml```

5. Configure routing to/from the VMs (future k8s nodes) e.g. using [routing to VM script](./scripts/add_route_to_env.sh), [routing from VM script](./scripts/setup_vms/routing_setup.sh) in case it's a local lab
6. Setup **k8s cluster** on the created nodes. I prefer [kubespray](https://kubespray.io/#/), but there are other options.
7. (optional) Install `kubectl` on the host machine ([official](https://kubernetes.io/docs/tasks/tools/install-kubectl/), [playbook](./ansible/playbooks/kubectl.yml))
8. (optional) setup other thesis related tools using Ansible. Refer to the [playbooks README](./ansible/README.md)
