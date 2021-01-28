# metallb

setup metal loadbalancer according to the installation doc - https://metallb.universe.tf/installation/
- setups all prerequisites and required k8s resources

## Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (go bianry) on target node

## Dependencies

None

## Role variables

refer to defaults:
    - [main](./defaults/main.yml)

## Example playbook

    - hosts: node1.k8s.sk
      roles:
        - metallb

## Author information

Tomas Bellus
