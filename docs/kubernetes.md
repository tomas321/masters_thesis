# Kubernetes fundamentals

## Architecture

- nodes
- pods
- containers

## Kubernetes Design Principles

from: [Kubernetes Design Principles: Understand the Why - Saad Ali, Google](https://www.youtube.com/watch?v=ZuIQurh_kDk)

1. Kube API is declarative rather than imperative
2. No hidden internal APIs
3. Meet the users where they are or make the current applications compatibile with k8s
4. Workload portability

### components

All components, except the server API, monitors the k8s API and acting on a set of API objects.

server API (main component):
- hosted on the master node
- holding all pod descriptions

scheduler:
- hosted on the master node
- monitors the server API for unscheduled pods - API objects lacking assigned node.
- in just updates the node in the description on the server API

A/D controller (attach detach)
- communicates with various storage backends - according the technology
- monitors the serve API for pods attached to a node and referencing a remote volume (type)

### kube API

SecretAPI object:
- no sensitive information included in containers
- passwords, certificates, etc. are provided at runtime via this object

ConfigAPI object:
- e.g. application startup parameters

DownloadAPI object:
- fetch pod information e.g. name, namespace, uid

The k8s API is declarative rather than imperative [also documented here](https://thenewstack.io/the-declarative-power-of-apis/)
- The master node does not foreward the client's requests to the chosen node
- There are no specific set of instructions to drive the node to a desired state
- Rather the worker nodes are responsible for driving themselves to that defined desired state

In case of the traditional imperative API architecture, the master node would become complex, brittle and difficult to extend. It would be in charge of node/pod monitoring, ensuring the state on each of them is correct. Instead the worker nodes taps into the API server to check for infrastructure changes regarding only the node at hand. Meaning, all component updates are level triggered instead of edge triggered. Advatage of level triggered components is no more "missing event" issue.

Despite the centrilized architecture of a k8s cluster with server API at the center, all components are idenpentent of each other (orthogonal). In any case of a component going down, other continue to function, therefore there is no single point of failure. Even if the server API component crashes, all nodes continue to function on the last state.

### storage attachment

- the A/D controller monitors for pod definitions with attached node and are referencing a remote volume
- requests the storage backend to attach the volume if unavailable on the node yet (thats identified in the server API as a `attached` variable)
- as it goes for all nodes, the node (kubelet) monitors the node config on server API to mount the volume to container if the storage is attached

As of version 1.13 the direct storage referencing is not adviced, because it would make the pod not portable to different cluster not supporting that particular volume type. Instead k8s introduces persistent volume (PV) and persistent volume claim (PVC) interface to resolve this. With this the pod should reference the PVC API object.
