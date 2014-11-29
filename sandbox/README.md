# Docker Base OS
Have a base OS that you can SSH into via Vagrant.

## Vagrant + Docker
I use [vagrant](http://www.vagrantup.com/) and I love it.  Vagrant allows you create development environments via virtual machines.  Vagrant makes use of Docker by building the machines with Docker.  Docker does not create a VM but a light weight linux container.

Read more about Docker [here](https://www.docker.com/), its amazing.

## Setup
### Requirements
You will need docker and vagrant installed on your system.

### Build the container
Creating the container is a simple as running vagrant up.

```
$ vagrant up
```

You should see something built out:

```
$ vagrant up
Bringing machine 'centos' up with 'docker' provider...
==> centos: Building the container from a Dockerfile...
    centos: Image: 1c67bb1c50a8
==> centos: Fixed port collision for 22 => 2222. Now on port 2200.
==> centos: Creating the container...
    centos:   Name: centos
    centos:  Image: 1c67bb1c50a8
    centos: Volume: /home/USER/workspace/vagrant-verify/centos:/vagrant
    centos:   Port: 2200:22
    centos:
    centos: Container created: 1c5f8f61e8a487d6
==> centos: Starting container...
==> centos: Waiting for machine to boot. This may take a few minutes...
    centos: SSH address: 172.17.0.92:22
    centos: SSH username: vagrant
    centos: SSH auth method: private key
==> centos: Machine booted and ready!
```
