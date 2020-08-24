# Kubernetes fundamentals

## Architecture

from: [source](https://kubernetes.io/docs/concepts/)

### k8s control plane
- setups the cluster to desired state via Pod Lifecycle Event Generator (PLEG)
- k8s master node consisting of _API server_, _controller manager_ and _scheduler_ processes
- k8s non-master nodes run _kubelet_ process, which communicates with the k8s master and _kube-proxy_ process, which reflects k8s networking services

### nodes
- virtual or a physical machine hosting pods (holds container(s))
- contains service necessary for running pods, managed by the k8s control plane
- in addition to _kubelet_ and _kube-proxy_ it contains the chosen container runtime

**Node management**
- Nodes are registered to the API server either:
    1. the kubelet on the node self registers to the control plane
    2. human user manually adds a node object
- each registered node, must be considered healthy by the k8s to be eliible to run a pod.
    - NOTE: a node's health is periodically checked and unhealthy nodes are ignored for any cluster activity. The checking may be only manually stopped by deleting the node object
- self-registration nodes run the kubelet with specific set of arguments to successfully define the node at hand
    - the main option `--register-node` must be included
- for the manual registration, set the `--register-node=flase` option of the kubelet command
    - the nodes are created and modified using the `kubectl` tool
    - with manual node administration control the pod scheduling, **which does not affect existing pods!**

**Node status**
It provides the information including _addresses_, _conditions_, _capacity and allocatable_ and _info_.
- refer to this [link](https://kubernetes.io/docs/concepts/architecture/nodes/#node-status)

### containers
- packaging technology ran from immutable container images
- independent of hosting OS, running under a specific container runtime (e.g. _Docker_ and _CRI-O_)

### k8s object

**pod**
- represents a proces as the smallest unit running on a cluster, but it is not a process rather an evironment for running a container
- encapsulates a container (sometimes more), storage resource, uniq net id (IP addr) and additional options
- k8s provides horizontal application scaling, called replication, of pods
- multiple container deployment:
    - the containers must be of small number, share resources and "tightly coupled"
    - co-existing containers communicate via `localhost` and share a public network interface
- pods are managed by k8s controller (higher abstraction level) and are not self-healing instances

**service**
- an abstract way of running an application on a set of pods
- defining a service include proxying the incoming traffic to specified port
- _kube-proxy_ is a crucial element, responsible for implementing a form of virtual IP for all service types **except ExternalName**
    - it's responsible for proxying traffic to the right endpoint pod
    - the kube-proxy may run in user-space, iptables and IPVS mode
    - **user-space** mode selects a pod via a round-robin algorithm
    - **iptables** mode selects a pod at random
    - **IPVS** selects a pod via any of [round-robin, least connection, dest or src hashing, shortest expected delay, never queue] algorithm.
- multi-port services and custom IP address are supported
- services may be discovered when pods are ran on the node
    - kubelet adds a set of environment variables
    - with the DNS service enabled, other services may be discovered via DNS records
    - service discovery via DNS SRV records allows retrieving the service ports [link](https://kubernetes.io/docs/concepts/services-networking/service/#dns)
- a headless service is not managed by the kube-proxy and may be with or without selectors

**volume**
- bound to the life of a pod
- outlives all container restarts within a pod
- at its core, volumes are directories mounted to the specified containers
- there are numerous [volume types](https://kubernetes.io/docs/concepts/storage/volumes/#types-of-volumes) supported by k8s

**persistent volume**
- consists of two API resources - _PersistentVolume_ (PV) and _PersistenVolumeClaim_ (PVC)
- PersistentVolumes are pieces of storage resource in k8s cluster simalar to as a node is a resource to the cluster
    - They are volume plugins as Volumes, but have a lifecycle independent of any individual Pod that uses the PV
- PersistentVolumeClaims are user requests similar to a pod - pods consume node resources and PVCs consume PV resources
    - claims can request specific size and access modes (e.g. RW, RO)
    - PVCs and PVs get bound together when a match is found
    - pods use PVCs as volumes, the API object is specified in `volume` block as `persistentVolumeClaim`
    - both PV and PVC are protected from deletion, which is postponed apon a request until the PVC or PV is not used or bound to its PVC respectively
- a volume may be reclaimed with _delete_, _recycle_ (deprecated) or _retain_ policy

**namespace**
- virtual cluster
- It is not necessary to use multiple namespaces just to separate slightly different resources, such as different versions of the same software: use labels to distinguish resources within the same namespace.

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
