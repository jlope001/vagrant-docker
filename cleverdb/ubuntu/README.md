# Dockerfile Vagrant CleverDB agent - Ubuntu
Setup a [CleverDB agent](https://cleverdb.io) that will connect to a database server and CleverDB services.
Setup your own mysql server 5.6 image with CentOS 6.

## Vagrant + Docker
I use [vagrant](http://www.vagrantup.com/) and I love it.  Vagrant allows you create development environments via virtual machines.  Vagrant makes use of Docker by building the machines with Docker.  Docker does not create a VM but a light weight linux container.

Read more about Docker [here](https://www.docker.com/), its amazing.

## Setup
### Requirements
You will need [docker](https://www.docker.com/) and [vagrant](http://www.vagrantup.com/) installed on your system.  You will also need access to a MySQL Server.  I've also set this up to be linked automatically with a docker mysql server.  I have one setup [right here](https://github.com/jlope001/vagrant-mysql).

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
Bringing machine 'cleverdb' up with 'docker' provider...
==> cleverdb: Building the container from a Dockerfile...
    cleverdb: Image: 6ce06660d22b
==> cleverdb: Creating the container...
    cleverdb:   Name: cleverdb
    cleverdb:  Image: 6ce06660d22b
    cleverdb: Volume: /home/USER/workspace/vagrant-cleverdb-ubuntu:/vagrant
    cleverdb:   Link: mysql:mysql
    cleverdb:
    cleverdb: Container created: 0db1e2fc809b2a80
==> cleverdb: Starting container...
==> cleverdb: Provisioners will not be run since container doesn't support SSH.
```

Once completed, you should have an agent that will automatically be linked to the MySQL server and CleverDB.
