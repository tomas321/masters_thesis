issue #8: existing solutions

# malware analysis tools

## [cuckoo sandbox](https://cuckoo.sh/docs/)

- supports win, macos, linux and android
- dynamic file analysis tool with reporting
- cuckoo is different in a way of knowing the malware (pid, filename, etc.)
    - it knows where to start and what traces to follow..

### [sandboxing](https://cuckoo.sh/docs/introduction/sandboxing.html)

- suggests to leave traces of normal in the environment if the malware is interested in such
    - cookies
    - browsing history
    - documents
    - ...
- suggests to hide as many virtualization traces (if necessary) as possible

### [concept](https://cuckoo.sh/docs/introduction/what.html)

- retrieves the following types of results:
    - Traces of calls performed by all processes spawned by the malware.
    - Files being created, deleted and downloaded by the malware during its execution.
    - Memory dumps of the malware processes.
    - Network traffic trace in PCAP format.
    - Screenshots taken during the execution of the malware.
    - Full memory dumps of the machines.
- consists of the management software (host machine) and a number of virtual/physcal machines for analysis


## [Droidbox](https://github.com/pjlantz/droidbox)

- dynamic file analysis tool
- dedicated to android application
- analysis the application and reports:
    - Hashes for the analyzed package
    - Incoming/outgoing network data
    - File read and write operations
    - Started services and loaded classes through DexClassLoader
    - Information leaks via the network, file and SMS
    - Circumvented permissions
    - Cryptographic operations performed using Android API
    - Listing broadcast receivers
    - Sent SMS and phone calls

## virustotal

- dynamic/static file analysis
- uses antivirus engines, website scanners and blacklists

## falcon sandbox
[hybrid-analysis.com](hybrid-analysis.com)
- similar to cuckoo, but claims to bemore effective and precise

## [and more](https://www.g2.com/categories/malware-analysis-tools?utf8=%E2%9C%93&order=top_shelf)

# active analysis (honeypots/honeynet), deception technologies

## [Honeynet based distributed adaptive network forensics and active real time investigation](https://www.researchgate.net/publication/221001129_Honeynet_based_distributed_adaptive_network_forensics_and_active_real_time_investigation)

- requested a full text document from the author via th platform.. no luck yet

## guardicore - not a vendor, just a blog

- first [mention](https://www.guardicore.com/2018/10/dynamic-honeypot-cyber-security/) of a dynamic honeypot, which generates live environments that adapt to the attackers

## [honeystat](https://people.engr.tamu.edu/guofei/paper/honeystat.pdf)

- event-based network of honeypots
    - memory event - logs and alerts from third-party software
    - network event - e.g. outgoing traffic SYN packet
    - disk event - file modifications
- concentrates on worm infections
- include a PoC with Blaster worm attack (divided to these events)
    - time-based graph to map the changes
- includes a analysis Node (out of scope)
- honeypot evasion

## [honeypoint](https://www.microsolved.com/honeypoint) by microsolved inc.

- services emulation
- consists of various compenents that could be replicated into the k8s architecture. [what is honeypoint](https://stateofsecurity.com/what-is-this-honeypoint-thing-anyway/)
    - it's a robust architecture to mimic a complex network environment for deceiving an attacker
- good podcast about deception technologies and honeypots
    - Microsolved inc. CEO Brent Huston [claims](https://www.podbean.com/media/share/pb-cgwhv-ad161e?utm_campaign=w_share_ep&utm_medium=dlink&utm_source=w_share) that having a honeypot is a great deception technology with almost no false positives, since it is expected that no legitimate user iteracts with it. It means that any recorded activity should be consider suspicious, if the honeypot targets malicious actors scanning the internet regardless of possible domain. NOTE: no one randomely tries IP addresses and look for a service.
- deployment of honeypoint in 2 hours with couple of emulated services, decoy sensors and consoles for interaction
- honeypoint personal edition turns attacker targets into security sensors (emulates services)

## [cybertrap](https://cybertrap.com/solutions/#endpointdeception)

- deploys lures/baits to endpoints ussually used by attackers
- the baits cannot be distiguished by an attacker
- no damge is done to the production env
- IMHO sits paralell to the prod env
- not much docs provided (commercial)

## [study](https://www.researchgate.net/publication/262277761_A_distributed_platform_of_high_interaction_honeypots_and_experimental_results): A distributed platform of high interaction honeypotsand experimental results

TODO

## [study](https://arxiv.org/pdf/1701.02446.pdf): SIPHON: Towards Scalable High-Interaction PhysicalHoneypots

TODO


# NOTES

[Automated Static Analysis vs. Dynamic Analysis - Better Together?](https://blog.reversinglabs.com/blog/automated-static-analyis-vs.dynamic-analysis)
- must hide the fact that its a sandbox, otherwise the malware will not start
    - detection of lack of applications and files
    - delayed malware execution
    - password-protected attachments cannot be opened in a sandbox environment
    - encrypted traffic

- [use automated static malware analysis](https://blog.reversinglabs.com/blog/how-soc-analysts-and-threat-hunters-can-expose-hidden-malware-undetected-by-edrs)
    - latest generation of static malware analysis uses automation, ML and integrations to speed up the process, which is very time-consuming
    - tools like this are purpose-build to overcome the complexity

- [From Honeypots to Active Deception Defenses](https://fidelissecurity.com/threatgeek/deception/honeypots/) modern deception strategy should accommodate these features:
    - Automated discovery – continuously maps networks, assets, resources and services creating profiles to learn the ‘real’ environment.
    - Automated decoy creation – builds optimal decoys with interactive services and applications to engage attackers or malware with what they desire.
    - Automated deployment – positions a wide variety of decoys in optimal locations with a mixture of breadcrumbs on real assets as lures to make deception deterministic.
    - Active response – enables security teams to script and automate workflows for active response and investigation.
    - Automatically adapts – to changes in networks, assets, resources or services to update discovery profiles and enable the automation of new and updated decoys and breadcrumbs.

- High-interaction honeypots can redirect the attacker to some virtual machine or a sandbox or use real dedicated machines to make the environment look as realistic as possible. These malware detection systems are much harder to develop due to the difficulty of creating multiple environments simultaneously. [link](https://www.apriorit.com/dev-blog/568-honeypots-for-malware-detection)
    - anti-honeypot techniques:
        - number of connections to the C2 server, in case the malware sample is ran in multiple environments at the same time
        - number of infection attempts - run once tactics to identify a honeypot and block further exection of more than one attemp is made to infect a particular host
- LOOK FOR DECEPTION TECHNOLOGIES
    - "The aim of deception technology is to prevent a cybercriminal that has managed to infiltrate a network from doing any significant damage. The technology works by generating traps or deception decoys that mimic legitimate technology assets throughout the infrastructure. These decoys can run in a virtual or real operating system environment and are designed to trick the cybercriminal into thinking they have discovered a way to escalate privileges and steal credentials. Once a trap is triggered, notifications are broadcast to a centralized deception server that records the affected decoy and the attack vectors that were used by the cybercriminal." [link](https://www.forcepoint.com/cyber-edu/deception-technology)
    - im comparison with honeypot/honeynet it aims to trap and deceive with high-interaction techniques including the analysis of attackers' lateral movement. [darkreading blog](https://www.darkreading.com/vulnerabilities---threats/advanced-deception-how-it-works-and-why-attackers-hate-it/a/d-id/1330600)
    - a deception technology aims to trap on suspicious/malicious attempts, because no legitimate user should access it [darkreading blog](https://www.darkreading.com/vulnerabilities---threats/advanced-deception-how-it-works-and-why-attackers-hate-it/a/d-id/1330600)
    - deception technology is a state of the art approach to discover an attacker's agenda and prevent all potential negative scenarios [another darkreading blog](https://www.darkreading.com/threat-intelligence/deception-technology-prevention-reimagined-/a/d-id/1330408?piddl_msgid=330023)
- its not imporatant to collect all low-end data such as packet capture to detect an attacker presence and take action [brent huston, podcast](https://www.podbean.com/media/share/pb-cgwhv-ad161e?utm_campaign=w_share_ep&utm_medium=dlink&utm_source=w_share)


## design ideas

- must have a termination point at which is the honeynet terminated to stop spreading
- look out for the [catch-22](https://en.wikipedia.org/wiki/Catch-22_(logic)) contradictory issue
- use case: admin has found a backdoor in the organization's network
    - setups the same backdoor in a isolated environment and direct the malicious actor to that islocation env for further monitoring and analysis

- module like architecture to differentiate the target malwares being detected
    - the modules would differ in deployment, services, configation, dependency installations and monitoring toolset

- work towards easy scalability and variablity (k8s)
- include automated bot users to play as real users as [honeybees](https://stateofsecurity.com/what-is-this-honeypoint-thing-anyway/) in honeypoint solution.
- my solution should be a deception technology based on k8s with additional full freedom for the visitor, unlike a honeypot which aims to stop the attacker as soon as possible and gather IOCs.
- dynamically changing the attack surface? [darkreading blog](https://www.darkreading.com/vulnerabilities---threats/advanced-deception-how-it-works-and-why-attackers-hate-it/a/d-id/1330600)
    - acts as a deterrent and only could be experimented with to see the effect
- have low interaction honeypots in the perimeter to lure the attackers in a hole/network full of high-interaction deception services
    - technologically the low-interaction honeypots will appear as points of access (e.g. SSH server).. a connection to it would be routed to a full-interaction server in the network (k8s cluster)
- k8s cluster of remote servers all over the internet?
