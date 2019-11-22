# Výskumý zámer

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
    - Motivácie, ciele a predpokladané výstupy DP .
- Plán na tri semestre pre spracovanie DPI, DPII, DPIII.
- LITERATÚRA
    - primárne vedecké zdroje, ale aj ďalšie, ktoré boli použité vo výskumnom zámere

# Immutable infrastructures for security demanding environments, Tomáš Belluš, Tibor Csóka

## Motivation


## Analysis
[Docker and Kubernetes in high security environments](https://medium.com/@chrismessiah/docker-and-kubernetes-in-high-security-environments-d851645e8b99) is a case-study at the Swedish Police Authority by Christian Abdelmassih. The main goal of the case-study is to mitigate any form of escape attacks. The author discusses application isolation techniques while providing orchestration with Kubernetes. One technique is to isolate applications by containerization (e.g. Docker, LXC, etc.), which share the host's kernel. Second technique is separation by bare-metal hypervisor - virtual machines (VM). This means that the VM has it's own operation system (OS) and shares hardware resources of the host. In conclusion, the idea is to utilize bare-metal hypervisor (cloud native) to minimize the attack surface for escape attacks, because containers are vulnerable to kernel driven escape attacks. To separate non-related application and utilize containers, he suggests segementation of Kubernetes pods to logical classes (e.i. class O, class P and class PG). These classes are to be organized and orchestrated by Kubernetes and should make sure nodes and pods have the same class tags. Although, the solution was but present and lacks verification which opens opertunities for my thesis, as the the author finalizes that "In order to utilize this in clouds in a scaleable manner, there are additional requirements for automation that must be satisfied. For example, automating the creation of virtual machines, attaching them to the Kubernetes cluster. Most importantly one must also implement and verify that the application classifications are respected at all times." [Chistian Abdelmassih, 24.01.2019]

## Future work

## Plan (DPI, DPII, DPIII)

## References
