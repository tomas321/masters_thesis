# Výskumný zámer

- Cieľ
    - Rozpracovať vybraný z trendov výskumu v oblasti inteligentnýh softvérových systémov vo forme zámeru výskumného projektu
- Forma
    - písomný dokument v rozsahu 8-10 strán A4
- Názov, meno študenta a vedúceho DP.
- Motivácia - pomenovanie problému
    - Prečo je tento problém dôležitý
- Analýza stavu problematiky
    - Stručne analýza s citovanou literatúra .
- Rozpracovanie problému
    - Tézy, výskumné otázky
    - Motivácie, ciele a predpokladané výstupy DP.
- Plán na tri semestre pre spracovanie DPI, DPII, DPIII.
- LITERATÚRA
    - primárne vedecké zdroje, ale aj ďalšie, ktoré boli použité vo výskumnom zámere
- TEMA?
    - migitating virtualization detection, sandbox/honeypot detection, escape attacks
    - detecting zero days
        - being independent of the malware (simulating of zero days by using a known vulnerablity)

------

## STU - FIIT

# Immutable infrastructures for security demanding environments - Aim of research

## Tomáš Belluš

### Supervised by: Tibor Csóka

------

## Motivation

How to successfully delivery, exploit and compromise a target system? Cyber criminals (attackers) follow a multi-phase process to completely plan the sophisticated attack. The phases fall under so called `Cyber/Intrusion Kill Chain` and include - `reconnaissance`, `weaponization`, `delivery`, `exploitation`,  `installation`, `command and control`, `actions on objective` [[source](https://maritime-executive.com/blog/the-seven-phases-of-a-cyber-attack)].  Briefly, the attack begins with analyzing and discovering the target objective, followed by preparation of the exploit to compromise the system and getting required control to fulfill a goal.

In contrast to the attackers, security experts use equally complex and useful tools and practices to detect, mitigate or reproduce an attack. Tools like sandbox, sinkhole, honeypot and many active detection tools (e.g. WAF, IPS/IDS, FW, etc.) In the "fight" of blue versus red, the blue team must keep up with the red teams'  techniques and zero-day exploitation. Zero-day exploitation, or attack, target vulnerabilities not addressed by vendors and not publicly known (beside the attackers) [[source]()].Such vulnerabilities are almost impossible to mitigate and very difficult to detect. White hat or ethical hackers search for these vulnerabilities in their own environments by reading all those lines of code or dynamically - utilizing honeypots.

Detecting zero-day vulnerabilities in a honeypot may result in a absolute failure of the honeypot. The immutable infrastructure paradigm would ensure the whole environment may be recovered. Usage of immutable infrastructure may introduce the possibility of designing a complex honeynet composed of multiple interconnected network segments and devices.

## Analysis

"The primary technology that makes immutable infrastructure possible at any scale is virtualization (both software and hardware) across networking, servers, and storage" [[source](https://www.sumologic.com/insight/mutable-immutable-infrastructure/)]. According to this, virtualization is the inseparable element of immutable infrastructure.

### Immutable infrastructure and its orchestration

To understand the applications of immutable infrastructure one must identify its characteristics. Any system or unit of a system (i.e. container, VM, server) is pre-configured and deployed to its final state in a target environment. The state is immutable - it forbids any further configuration changes or additional networking. Required changes are applied in the "infrastructure configuration" (e.g. container images) and redeployed to apply the updated state. In comparison, a mutable infrastructure is the exact opposite, such as almost every computer, that requires manual step-by-step installation of the OS and the underlying applications and network configurations.

Having a complex infrastructure composed of multiple servers/containers (any solo-standing service) allows segmentation of immutable services. Instead of upgrading/modifying a whole infrastructure, only the desired segments are addressed. Although, it introduces a problem of orchestration and segmentation of services to the smallest unit (i.e. container). Possible segmentation of services is discussed in the next section - Escape attack mitigation. Orchestration is the question of how, when and what combined in a single process of the mechanism used.

The immutability has a profound effect on the security of the infrastructure. Since every change is made by redeploying the infrastructure, all ongoing attacks vanish despite being as complex as outlast a reboot. **Although, the data stores (i.e. databases, message queues) are very much mutable components of the infrastructure, therefore they should be subject to analysis.**

### Escape attack mitigation

Escape attacks exploit vulnerabilities in shared resources or stack level (e.g. kernel for KVM, application for functions or hardware for virtualization). A case study, with a goal to mitigate any form of escape attacks, at the Swedish Police Authority by Christian Abdelmassih -  [Docker and Kubernetes in high security environments](https://medium.com/@chrismessiah/docker-and-kubernetes-in-high-security-environments-d851645e8b99). The author discusses application isolation techniques while providing orchestration with Kubernetes.

One technique is to isolate applications by containerization (e.g. Docker, LXC, etc.), which share the host's kernel. Second technique is separation by bare-metal hypervisor - virtual machines (VM). This means that the VM has it's own operation system (OS) and shares hardware resources of the host. In conclusion, the idea is to utilize bare-metal hypervisor (cloud native) to minimize the attack surface for escape attacks, because containers are vulnerable to kernel driven escape attacks.

To separate non-related application and utilize containers, he suggests segementation of Kubernetes pods to logical classes (e.i. class O, class P and class PG). These classes are to be organized and orchestrated by Kubernetes and should make sure nodes and pods have the same class tags. Although, the solution was but present and lacks verification which opens opertunities for my thesis, as the the author finalizes that "In order to utilize this in clouds in a scaleable manner, there are additional requirements for automation that must be satisfied. For example, automating the creation of virtual machines, attaching them to the Kubernetes cluster. Most importantly one must also implement and verify that the application classifications are respected at all times." [Chistian Abdelmassih, 24.01.2019]

### Honeypots & Sandboxes

briefly about them...

## Master's thesis overview



Ansible utilizations

Kubernetes usage

Containers pros and cons, unikernel

Sandbox as a Dynamic analytic tool providing all required connections by the malware or bot

####Plan of work

##### DP I

|      |      |
| ---- | ---- |
|      |      |
|      |      |
|      |      |

##### DP II

|      |      |
| ---- | ---- |
|      |      |
|      |      |
|      |      |

##### DP III

|      |      |
| ---- | ---- |
|      |      |
|      |      |
|      |      |



## Literature and references

https://pdfs.semanticscholar.org/d4e4/5e81b8d8878ca99648c3fc890ede1ae01b49.pdf

https://kth.diva-portal.org/smash/get/diva2:1231856/FULLTEXT02.pdf

https://www.enisa.europa.eu/publications/proactive-detection-of-security-incidents-II-honeypots


