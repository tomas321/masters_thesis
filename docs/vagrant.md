# Vagrant

- VM environment building tool
    - single workflow
    - automated
    - increases productoin parity
- environments on top of industry-standard tech

## boxes

- easy to clone base images
- can be local, custom url or from vagrant cloud box registry
- addding a box to vagrant file
    - either via the `vagrant init` command
    - or literally - `vagrant box add user/boxname`

### building a custom box

[packer](https://github.com/hashicorp/packer) by hashicorp for building custom images

## project setup

- vagrantfile
    - marks the directory root of a project
    - machine resources
    - VM access
    - additional software

```bash
user@pc:~/thesis$ mkdir vagrant && cd vagrant
user@pc:~/thesis/vagrant$ vagrant init mai7star/ubuntu
```

Example vagrant file contents:
```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "mai7star/ubuntu"
  config.vm.box_version = "1804.1.0"
end
```

## building the environment

- `vagrant up`
    - builds and runs the VM
- `vagrant ssh`
    - ssh session to the VM

### multiple machines

```ruby
Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: "echo Hello"

  config.vm.define "web" do |web|
    web.vm.box = "apache"
  end

  config.vm.define "db" do |db|
    db.vm.box = "mysql"
  end
end
```

### synced folders

- on the VM `/vagrant` folder is synced with the project root dir (where Vagrantfile is)
- the VM home directory `/home/vagrant` is not to be interchanged with the synced folder
- disabling the default synced:
```ruby
config.vm.synced_folder ".", "/vagrant", disabled: true
```


### provisioning

- call ansible after building the VM to prosision further services and applications
```ruby
config.vm.provision "ansible" do |ansible|
  ansible.playbook = "playbook.yml"
end
```

### networking

- configure a static ip address with no additional vagrant configuration
```ruby
config.vm.network "private_network", ip: "192.168.50.4", auto_config: false
```

## [libvirt-specific configuration](./vagrant_libvirt.md)
