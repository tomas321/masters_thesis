issue #11 optimal/minimal and efficient cluster setup

# cluster setup

follow these architecture prerequisites:
    - what to observe
    - how to observe it
    - how to isolate the system
    - how to store the observed data
    - how to combine and evaluate data in the wider context

At first, propose multiple static scenarios and environments with coresponding obervables, goals and expectations. The scenarios will define my observation methodology. Then continue with dynamic environments.

## scenarios

- web + db + mail (?) + ...
- IOT scenario


# honeynet concealment strategies

The constructed honeynet must mimic a real environment so a malicious actor will take the bait and trust the system. This sections outlines suggested artefacts and mechanisms used to simulate user activity and network traffic - **noise-like generators**.

## environment simulation

In the [official cuckoo documentation](https://cuckoo.sh/docs/introduction/sandboxing.html), they suggest to:
    - leave traces of normal activity in the environment:
        - cookies
        - browsing history
        - documents
        - images
        - ...
    - hide as many virtualization traces as possible

since a malicious actor may be interested in them. In honeynets, the point is to see how the adversary enters and how he traverses the system, therefore the perceived behavior in the system should mimic a real system (NOTE from supervisor).

Idea is to have an environment per malicious actor, but it is expected to have only one malicious actor a time. Alternative is to have all intruders meet up in the same environment.

High-interaction honeypots in a way of deploying full services is in favor of being prepared for the malicious actor to exploit a bug, which would not be emulated/implemented

## virtualization traces

TODO
