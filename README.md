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

1. Clone the repository.
    - `git clone https://github.com/tomas321/masters_thesis`
2. Setup a ssh key pair for accessing the nodes.
    - `ssh-keygen -t rsa -N <your_passphrase> -f ~/.ssh/id_vagrant_k8s` - generate simple key pair
        - in case you like to chnage some parameters, you may except the output file `-f` option
3. Run the Ansible [setup kvm playbook](./ansible/playbooks/setup_kvm.yml) as root.
    - ```bash
      cd masters_thesis/ansible
      ansible-playbook -K playbooks/setup_kvm.yml
      ```
4. Run the Ansible [vagrant k8s up playbook](./ansible/playbooks/vagrant_k8s_kvm.yml) as root.
    - ```ansible-playbook -K playbooks/vagrant_k8s_up.yml```
5. Install `kubectl` on the host machine ([link](https://kubernetes.io/docs/tasks/tools/install-kubectl/))
