# Vagrant / Docker / Memcached
Simple memcache server in docker

## Vagrant + Docker
I use [vagrant](http://www.vagrantup.com/) and I love it.  Vagrant allows you create development environments via virtual machines.  Vagrant makes use of Docker by building the machines with Docker.  Docker does not create a VM but a light weight linux container.

Read more about Docker [here](https://www.docker.com/), its amazing.

## Setup
### Requirements
You will need [docker](https://www.docker.com/) and [vagrant](http://www.vagrantup.com/) installed on your system.

### Environment Variables
Instead of storing sensitive information in this public repository, I make use of environment variables that you pass in.  Please refer to the defaults.env in order to know what variables are required to pass in.  This will allow you to automatically setup an agent with no effort.

### Build the container
Creating the container is a simple as sourcing the defaults file and running vagrant up.

```
$ source defaults.env; vagrant up
```

You should see something built out:

```
$ source defaults.env; vagrant up
==> memcached: Building the container from a Dockerfile...
    memcached: Image: f11de0d5e3f6
==> memcached: Creating the container...
    memcached:   Name: memcached
    memcached:  Image: f11de0d5e3f6
    memcached: Volume: /home/USER/workspace/vagrant-memcached:/vagrant
    memcached:
    memcached: Container created: c94717b0b945f7aa
==> memcached: Starting container...
==> memcached: Provisioners will not be run since container doesn't support SSH.
```
