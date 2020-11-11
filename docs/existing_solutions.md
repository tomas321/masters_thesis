issue #8: existing solutions

Honeypot, sandbox and deception technology make up the leading techniques in dynamic malware analysis. They differ in the scope of knowledge before the analysis at hand. Some know the filename, malware type, other artifacts and possible the expected outcome (in which case the tool observes the behavior). Other analyze the behavior of all activity - searching for anomalies and malicious behavior indicators. The following sections briefly introduce the malware analysis existing solutions and studies.

# Malware file analysis solutions

Malware file analysis is a dynamic procedure when the filename and malware type is known. In comparison to the scope of this thesis, all use similar techniques of malicious activity observation/monitoring, but differ in use case scenarios.

## [Cuckoo sandbox](https://cuckoo.sh/docs/)

A most common sandbox environment for malware analysis by executing a given file in a sandboxed environment with reporting of the outcome. All files affecting mainstream operating systems i.e. Windows, macOS, Linux and Android are supported. In addition to known artifacts, cuckoo has  no interfering processes, so all traces must be followed and privide insight to the behavior. Based on the official cuckoo documentation, the system produces various results (the following artifacts are  copied from the documentation site):

- Traces of calls performed by all processes spawned by the malware.
- Files being created, deleted and downloaded by the malware during its execution.
- Memory dumps of the malware processes.
- Network traffic trace in PCAP format.
- Screenshots taken during the execution of the malware.
- Full memory dumps of the machines.

Despite all differences, cuckoo's architecture consists of the management software (host machine) and a number of virtual/physcal machines for analysis. It's a tool for different use case, so a comparison is insignificant.

## [Droidbox](https://github.com/pjlantz/droidbox)

Another open source tool, sadly discontinued several years ago, droidbox utilizes analyzes android applications using Android Virtual Devices (AVD) and the android emulator 4.1.1_rc6, which enables the android activity monitoring. Analyzed applications are sandboxed in the AVDs and afterwards reports the following results (the following artifacts are  copied from the documentation site):

- Hashes for the analyzed package

- Incoming/outgoing network data
- File read and write operations
- Started services and loaded classes through DexClassLoader
- Information leaks via the network, file and SMS
- Circumvented permissions
- Cryptographic operations performed using Android API
- Listing broadcast receivers
- Sent SMS and phone calls

Droidbox introduces a simple way of analyzing android applications via an existing API of the emulator.

## Virustotal

Similarly to cuckoo, virustotal utilizes both static and dynamic malware analysis. "VirusTotal's aggregated data is the output of many different antivirus  engines, website scanners, file and URL analysis tools, and user  contributions" [[link](https://support.virustotal.com/hc/en-us/articles/115002126889-How-it-works)].

## Falcon sandbox
A direct concurrency to virustoal is the [Hybrid Analysis](hybrid-analysis.com) tool powered by the Falcon sandbox. Again, it's similar to cuckoo, except the anti-evasion feature [[blog](https://inquest.net/blog/2018/03/12/defense-in-depth-detonation-technologies)], which allows, even sandbox-aware malware, to be analyzed despite their evasion techniques.

## [more sandbox realted malware analysis tools](https://www.g2.com/categories/malware-analysis-tools?utf8=%E2%9C%93&order=top_shelf)

Most certainly, there are numerous other sandbox based tools, but there are minimal differences.

# Active analysis

This section explores existing honeypot/honeynet technologies and a recently emerged concept - deception technologies. These technologies may be divided into two categories - [dynamic](https://www.guardicore.com/2018/10/dynamic-honeypot-cyber-security/) and static, where the environment adapt to the scenarios or remains unchanged respectively.

## [Honeystat](https://people.engr.tamu.edu/guofei/paper/honeystat.pdf)

Honeystat is a honeypot solution observing the behavior of the Blaster worm  and may be used to detect zero day worm threats. The authors assume the infection may be described in a systematic way, so by knowing the worm agenda and steps they model the monitoring procedure. The observation is event-based with memory, disk and network events. Since there are no regular users in the system, the memory events are e.g. interesting violations as buffer overflows and other. Disk events are file system modifications and network events should always be infection related outgoing traffic. Worms require a multi-host network to have spreading possibility, so honeystat is deployed in a multihomed VMWare environment (64 VMs * 32 IP addresses = 2^11 IP) with minimal honeypots.

The procedure when events are encountered is:

- The honeystat is capturing memory and disk events
- If a network event occurs, the honeypot is reset to stop further spread of the worm to other machines/honeypots.
  - Any previous memory/disk event is updated with additional information from the network event.
  - Resets ought to be faster in virtual environment. Host VM is not rebooted, only the virtual disk (VD) is kept in a suspended state before it's replaced with a fresh copy of a VD. The reset always completes before a TCP timeout.
- Other steps include an analysis node, which is out of scope of this thesis.

This solution does not introduce any isolation techniques beside utilizing virtualization and the emulation mechanisms are exposing the virtualized environment via e.g. BIOS strings or MAC address. All features and considerations for honeystat are purely for worm infection detection, other infection types could require more observables.

## [Honeypoint](https://www.microsolved.com/honeypoint) by microsolved inc.

Service emulation is what Honeypoint utilizes to lure malicious actors and detect their agenda. Production services lie in the same environment as the robust architecture of Honeypoint, which can mimic a complex network environment for deceiving an attacker. The Microsolved CEO Brent Huston [claims](https://www.podbean.com/media/share/pb-cgwhv-ad161e?utm_campaign=w_share_ep&utm_medium=dlink&utm_source=w_share) that having a honeypot is a great deception technology with almost no false positives, since it is expected that no legitimate user iteracts with it. It means that any recorded activity should be considered suspicious, if the honeypot targets malicious actors scanning the Internet regardless of possible domain - randomly trying IP addresses and looking for a services ought to have malicious intent. Consists of various components that could be replicated in the Kubernetes architecture design [[what is honeypoint](https://stateofsecurity.com/what-is-this-honeypoint-thing-anyway/)].

## [Cybertrap](https://cybertrap.com/solutions/#endpointdeception)

A purely documented (commercial) solution Cybertrap operates as a deception technology luring attackers away from production systems. Looking apart from that services in Honeystat are emulated, Cybertrap's deployed services cannot be distinguished by the attacker. Once the malicious actor gets inside such network, all his/her movements are tracked. In addition, the Cybertrap's network is inaccessible by regular users, so any activity within the simulated environment is consider malicious - minimal to none false positives. Cybertrap is close to the idea of the goal of this thesis - sandboxed honeynet.

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

## A distributed platform of high interaction honeypots and experimental results

A case [study](https://www.researchgate.net/publication/262277761_A_distributed_platform_of_high_interaction_honeypots_and_experimental_results) serving as a proof of concept in live Internet traffic observing malicious actors' trends and agenda. As a monitoring technique they patched the kernel's `tty` and `exec` modules to intercept the keystrokes and system calls respectively. The architecture is 4 machines anywhere in the world working as relays to the authors' local setup of VM honeypots. The traffic incoming to the public interface of the relay is routed to a GRE tunnel connected to the local VM.

In a SSH scenario the created a new syscall and modified the SSH server to use it in order to intercept the login credentials. Logged data is periodically copied from the VM disk to the host disk (such extractions should be undetected by the malicious actors). All login data is stored to the database of this structure:

- data from each ssh login attempt
- data from each successful ssh connection - tty buffer content and tty name
- data of programs executed  with parameters and the terminal in which it ran
- session data grouping ssh connections

### Experiment

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

## SIPHON: Towards Scalable High-Interaction Physical Honeypots

A case [study](https://arxiv.org/pdf/1701.02446.pdf), similar to the study before, serving as a proof of concept in live Internet traffic observing the IOT related malicious intents. Leveraging Shodan to appear visible and legitimate in the eyes of malicious actors, the honeypots where based on real devices. The architecture is divided into physical IOT devices, wormholes exposed to the Internet forwarding to the IOT devices via the proxy forwarder. Technically are devices separated using VLANs 802.1Q and the wormhole to forwarder connection are via reverse ssh tunnels. As compromise countermeasures the suricata IPS and IDS features are enabled in the local netowork and periodic resets of IOT devices.

They observed the influence of device listing in Shodan. The number of scans/connection attempts on the device has tripled between 'one week before listing' and 'one week after listing'. It proves that being visible by Shodan increases the possibility of attack reconnaissance on device at hand. Although, after two week after listing in Shodan, the connection attempts has decreased, which good piece of knowledge before implementation.


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
