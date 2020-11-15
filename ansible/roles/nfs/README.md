# NFS

This role can be logically split to 2 ansible roles, but they share variables which led to merging the to 1 distiguished by a role variable
- simple NFS server setup exporting single direcotry with given permissions
- deploy nfs-provisioner related k8s objects according the [official repo](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)

## Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (go bianry) on target node

## Dependencies

None

## Role variables

refer to defaults:
    - [main](./defaults/main.yml)
    - [Debian](./defaults/Debian.yml)

## Example playbook

    - hosts: nfs-server
      roles:
        - role: nfs
          vars:
            nfs_role_mode: export
            nfs_export_subnet: '192.168.0.0/28'

    - hosts: node1.k8s.sk
      roles:
        - role: nfs
          vars:
            nfs_role_mode: k8s-provisioner
            nfs_provisioner_server_ip: '192.168.0.3'

## Author information

Tomas Bellus
