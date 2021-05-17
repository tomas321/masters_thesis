# execsnoop

copies:
- a [caller script](templates/execsnoop_caller.sh.j2), which executes the execsnoop bcc command for the specific `--mntnsmap` option
- the systemd templated (with the mount NS map name in the `/sys/fs/bpf` dir) unit file
- configures logfile logging for the systemd service

## Requirements

None

## Dependencies

- the [caller script](templates/execsnoop_caller.sh.j2) utilizes **docker** and **execsnoop**
    - **execsnoop** - setup using [bcc](../bcc) ansible role or directly the [playbook](../../playbooks/bcc.yml)
    - **docker** - is expected to be present with and used by kubernetes

## Role variables

refer to defaults:
    - [main](defaults/main.yml)

## Example playbook

    - hosts: node1.k8s.sk
      roles:
        - execsnoop

## Author information

Tomas Bellus
