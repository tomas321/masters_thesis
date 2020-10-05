issue #8: existing solutions

# malware analysis tools

## [cuckoo sandbox](https://cuckoo.sh/docs/)

- supports win, macos, linux and android
- dynamic file analysis tool with reporting
- cuckoo is different in a way of knowing the malware (pid, filename, etc.)
    - it knows where to start and what traces to follow..

- cuckoo is application sandboxing, which is not my case (sandboxed honeynet), but it is using similar techniques to analysis/monitor/explore any activity

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
- similar to cuckoo
- according to a [blog](https://inquest.net/blog/2018/03/12/defense-in-depth-detonation-technologies) the falcon sandbox does offer an anti-evasion feature

## [and more](https://www.g2.com/categories/malware-analysis-tools?utf8=%E2%9C%93&order=top_shelf)

# active analysis (honeypots/honeynet), deception technologies

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

- includes an analysis Node (out of scope)
- honeypot evasion

## [honeypoint](https://www.microsolved.com/honeypoint) by microsolved inc.

- services emulation
- consists of various compenents that could be replicated into the k8s architecture. [what is honeypoint](https://stateofsecurity.com/what-is-this-honeypoint-thing-anyway/)
    - it's a robust architecture to mimic a complex network environment for deceiving an attacker
- good podcast about deception technologies and honeypots
    - Microsolved inc. CEO Brent Huston [claims](https://www.podbean.com/media/share/pb-cgwhv-ad161e?utm_campaign=w_share_ep&utm_medium=dlink&utm_source=w_share) that having a honeypot is a great deception technology with almost no false positives, since it is expected that no legitimate user iteracts with it. It means that any recorded activity should be considered suspicious, if the honeypot targets malicious actors scanning the internet regardless of possible domain. NOTE: no one randomely tries IP addresses and look for a service.
- deployment of honeypoint in 2 hours with couple of emulated services, decoy sensors and consoles for interaction
- honeypoint personal edition turns attacker targets into security sensors (emulates services)

## [cybertrap](https://cybertrap.com/solutions/#endpointdeception)

- deploys lures/baits to endpoints ussually used by attackers
- the baits cannot be distiguished by an attacker
- no damage is done to the production env
- IMHO sits paralell to the prod env
- not much docs provided (commercial)

### email request for more info
subject:
`More documentation/information about your product`

body:
```
Hello,

I'm an Information Security  student, studying at FIIT STU in Bratislava Slovakia. In my final thesis I'm looking for deception technology or honeypot/honeynet-like tools and mechanisms. Coming across your solution stoke me, that it's very similar to my scope of study. Do you have some other blogs or technical documentation that would explain your solution? I'm only asking for (without any engagement) additional information besides your official website (cybertrap.com).

Sincerely,

Tomas Bellus
```

## [study](https://www.researchgate.net/publication/262277761_A_distributed_platform_of_high_interaction_honeypots_and_experimental_results): A distributed platform of high interaction honeypotsand experimental results

### concept

- as a monitoring technique they patched the kernel's `tty` and `exec` module to intercept the keystrokes and system calls respectively
- in a SSH scenario they created a new syscall and modified the ssh server to use it
    - intercepting the login-password pair for the SSH server

- logged data is periodically copied from the VM disk to the host disk at given time of the day
    - the authors suggest it's a hard to identify by the attacker

- after that the data is stored in a database with a given structure
    - data from each ssh login attempt
    - data from each successful ssh connection - tty buffer content and tty name
    - data of programs executed  with parameters and the terminal in which it ran
    - session data grouping ssh connections

**architecture**
- 4 machines anywhere in the world working as relays to the authors' local setup of VM honyepots
    - the VMs ensure an isolated environment with one level of virualization

- the traffic incomming to the public interface of the relay, is routed to a GRE tunnel to the local VM

**experiment**
- in the period of 30 days, they monitored what are the most common log-password pairs when no accounts are created
    - they found that for most attempts the login and password were the same

- then for almost half a year they monitored the time it took the attacker to successfully login and to login with commands entered
    - in some cases the attacker managed to get root via system vulnerab exploit

- they encountered attackers changing passwords of other accounts on the system
- they sorted their findings by country (mostly china, usa, germany, uk, russia, romania, japan, brazil, france, south korea and netherlands)
- analyzed the intrusions and commands
    - mostly they tried to download programs from the same country the source IP originated from

- general trends of attacker behaviors:
    - check if i am alone on the system
    - system recon - OS name and version, processor characteristics
    - changes the password of current user
    - install an IP scan program and scans the IP range to recon for potential lateral movement
    - IRC client setup for receiving instructions
    - privilege escalation attempt

- general trends of attacker behaviors (with root):
    - change the root password
    - setup backdoor - open another port
    - checkout info about legitimate users of the computer via custom installed software
    - one attacker replaced the ssh client binary

## [study](https://arxiv.org/pdf/1701.02446.pdf): SIPHON: Towards Scalable High-Interaction Physical Honeypots

- IOT honeypots based on real devices
- they assume attackers use Shodan to identify the vulnerable IOT devices

**architecture**
- physical IOT devices as th devices under attack
- wormholes - live device on the Internet with exposed ports forwarding the traffic to the IOT devices
    - similarly to the study other [study](ihttps://www.researchgate.net/publication/262277761_A_distributed_platform_of_high_interaction_honeypots_and_experimental_results), the devices are spoofed all over the world

- the traffic is forwarded through a proxy _Forwarder_, which can act as a gateway to all devices on one network or even as a TLS MITM
    - the devices are technically separated  using VLANs 802.1Q
    - connection between the wormholes and the forwarder is via reverse ssh tunnel, which redircts a given port traffic. in addition the forwarder utilizes socat to redirect the connection to a specific device.

- finally it consists of a storage and analysis unit

**compromise countermeasures**
- periodic resets
- ips e.g. suricata
- iot specific low-level instrumentation connections (e.g. JTAG)


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

### article [How deception can change cyber security defences](https://www.sciencedirect.com/science/article/pii/S1361372319300089)

- "Deception technology has evolved and improved far beyond the honeypot  concept. Today, deception  is about being active in terms of luring and bait-ing attackers to a deception environment" - validates the need for my thesis as such
- the may goal of deception tech is to know what the attacker could be looking for and bait them with decoys
    - these decoys are not to be engaged with, and if so, most probably it's a malicious actor
    - it seam though that the a deception is not in a isolated environment but, coexisting in the productino environment of an organization
    - assumes to solve false positives
    - used for post-breach detection

- deception technology assumes to solve the long presence of attackers in the network (which is measured in months)
- the author proposes that "early detection is now more critical than ever".

### honeypot deception tactics [link](https://link.springer.com/chapter/10.1007/978-3-030-02110-8_3)

it's a chapter, citation: `Rowe N.C. (2019) Honeypot Deception Tactics. In: Al-Shaer E., Wei J., Hamlen K., Wang C. (eds) Autonomous Cyber Deception. Springer, Cham. https://doi.org/10.1007/978-3-030-02110-8_3`

- refers to "planning and integrating deception into computer security defences" [scholar link](https://scholar.google.com/scholar?q=M.%20H.%20Almeshekah%20and%20E.%20H.%20Spafford.%20Planning%20and%20integrating%20deception%20into%20computer%20security%20defenses.%20In%20Proceedings%20of%20the%202014%20New%20Security%20Paradigms%20Workshop%2C%20pages%20127%E2%80%93138%2C%20New%20York%2C%20NY%2C%20USA%2C%202014.%20ACM.)
- refers to "introduction to cyberdeception" [scholar link](https://scholar.google.com/scholar_lookup?title=Introduction%20to%20Cyberdeception&author=N%20C.%20Rowe&author=J.%20Rrushi&publication_year=2016)
- cybersecurity adapts the idea from military to use fake files/assets to lure and deceive (counterintelligence)
- all in all it summarizes what, in terms of a honeypot, can be simulated and utilized to deceive a potential attacker
    - fake users, responses, applications/services ...

- "Deception in recipient and location-at: An adversary’s activities can be routed to a 'sandbox' site where they can be better controlled"
- deceiving an malicious actor by provoding what they want in pieces to discourage them - as way of securing the infra
- "A sophisticated honeypot could use automated planning to better manipulate the user."
- the author suggests that unexpected message like random errors may be difficult for them to handle - i suppose it refers to low interaction honeypots not implementing all functionality
- moreover they suggest:
    - randomization of characters/files tend to look like encrypted files
    - other low-interaction honeypot tactics to deceive the attack about the functionality


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
- create a paralell environment to lure the attackers in (somewhere in the perimeter) an isolated network with "live" traffic and users to be as attractive as possible
    - problem could be the possibility of the attacker evading the real organization's production systems
