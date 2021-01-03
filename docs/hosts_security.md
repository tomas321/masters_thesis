issue #10 host security

# host security

- in case of a container escape attack
- the pod level must be secured
    - detect unwanted presence or access

## ideas

- no different from common detection mechanisms (NSM, IDS)
- nodes must be secured or sandboxed/isolated as much as possible to secure all the real assets (nodes as VMs or bare metal machines)
    - nodes at pod level are not controled to outstand the exected attacker activity
    - all possible mitigation techniques must be applied

- kuberentes management monitoring
- FS changes on key files
- firewall for suspicious connections from host
- securing the attack surface (open ports, API, user priveleges)
- PAM
- authorization (sudoers)
- audit and logging
- automation of all security hardening to avoid misconfiguration and lack of documentation which too is provided by e.g. Ansible.
- secure the container runtime on the host machine!

- kubernetes states that host security is not bundled with k8s

- monitoring server (VM) activity to detect an unlawful access

## existing solutions

- it is [suggested](https://platform9.com/blog/selinux-kubernetes-rbac-and-shipping-security-policies-for-on-prem-applications/) to secure the host using selinux

### best practices from platform9 [link](https://platform9.com/blog/kubernetes-security-what-and-what-not-to-expect/)

- Strive to write policies that can be reused indefinitely
- when possible, write policies that are as broad as possible
    - applicable to the whole cluster, rather than a single or subset of resources
- use apparmor or selinux
- setup TLS and certificate management between the Kubernetes api-server, etcd, kubelet, and other services

### [calico](https://github.com/projectcalico/calico)

- inter-host firewall

### cluster security from k8s [link](https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/)
