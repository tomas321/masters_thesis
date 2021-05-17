#!/bin/bash
#
# USAGE: $0
#

BPF_BASE_DIR="/sys/fs/bpf"
[[ ! -d $BPF_BASE_DIR ]] && echo "missing dir $BPF_BASE_DIR" >/dev/stderr && exit 0

bpfmaps=$(ls $BPF_BASE_DIR)
[[ -z "$bpfmaps" ]] && echo "no bpfmaps found" >/dev/stderr && exit 0

for bpfmap in $bpfmaps; do
    found=$(docker ps -qf "id=${bpfmap##*_}")

    # check if the container exists ($found should not be empty)
    [[ -n "$found" ]] && continue

    # else, remove the map and stop the corresponding service
    rm $BPF_BASE_DIR/$bpfmap
    systemctl stop execsnoop@$bpfmap
    echo "removed $BPF_BASE_DIR/$bpfmap and stopped 'execsnoop@$bpfmap' service" >/dev/stderr
done
