issue #9 pod and container monitoring

# container monitoring

Outline possiblities of how to setup the system, what to expect, what to do in order to extract as much information as possible, how to wire everything together.

- system call emulation or wrapping [link](https://www.lastline.com/labsblog/different-sandboxing-techniques-to-detect-advanced-malware/)
- in a introduced [platform](https://www.researchgate.net/publication/262277761_A_distributed_platform_of_high_interaction_honeypots_and_experimental_results) they patched the kernel's `tty` and `exec` modules to intercept the keystrokes and system calls respectively
- inter-container network traffic
- most of the [artefacts collected](https://cuckoo.sh/docs/introduction/what.html) by the cuckoo sandbox
    - Traces of calls performed by all processes spawned by the malware.
    - Files being created, deleted and downloaded by the malware during its execution.
    - Memory dumps of the malware processes.
    - Network traffic trace in PCAP format.
    - Screenshots taken during the execution of the malware.
    - Full memory dumps of the machines.

- some artefacts listed above may be achieved using _filebeat_ log collector, _auditbeat_ and _suricata_ as an IDS.
- monitor the system and not a malware
- snapshot + diff
- only have one chance to detect all artefacts
    - in case the malware uses anti-honeypot techniques to stop malware analysts to execute it multiple times - such as number of connections to C2 server, run-once tactics

- honeystat found that `kqueue` was efficient for virtual disk monitoring

# storage mechanisms

NOTE: should be a separate section after specifing what and how to monitor in my environment.

which storage mechanism?
design data schemes