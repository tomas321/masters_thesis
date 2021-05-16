# execsnoop

copies:
- an [execsnoop caller script](templates/execsnoop/caller.sh.j2), which executes the execsnoop bcc command for the specific `--mntnsmap` option
- a [tcptracer caller script](templates/tcptracer/caller.sh.j2), which executes the tcptracer bcc command for the specific `--mntnsmap` option
- the systemd templated (with the mount NS map name in the `/sys/fs/bpf` dir) unit file
- configures logfile logging for the systemd services

attempts to start existing services

## Requirements

None

## Dependencies

- both caller scripts utilize **docker** and **execsnoop**
    - **execsnoop** - setup using [bcc](../bcc) ansible role or directly the [playbook](../../playbooks/bcc.yml)
    - **docker** - is expected to be present with and used by kubernetes

## Role variables

[default variables](defaults/main.yml)

## Example playbook

    - hosts: node1.k8s.sk
      roles:
        - sneakpeek

## Author information

Tomas Bellus
