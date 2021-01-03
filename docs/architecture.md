# architecture

- sandboxed honeynet in a k8s environment mimicing a real environment
- PoC project
    - one of many ways to collect valuable information about malicious actors to anticipate future attacks

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
