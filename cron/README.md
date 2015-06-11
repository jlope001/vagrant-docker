# Cron Container
This vagrant file is to be used with owncloud container setup on owncloud.  It'll run scheduled jobs on a regular intervals

## Vagrant + Docker
I use [vagrant](http://www.vagrantup.com/) and I love it.  Vagrant allows you create development environments via virtual machines.  Vagrant makes use of Docker by building the machines with Docker.  Docker does not create a VM but a light weight linux container.

## Setup
### Requirements
You will need [docker](https://www.docker.com/) and [vagrant](http://www.vagrantup.com/) installed on your system.

### Build the container
Creating the container is a simple as sourcing env file and running vagrant up.

```
$ source defaults.env; vagrant up
```

You should see something built out:

```

$ source defaults.env; vagrant up
==> cron: The container hasn't been created yet.
Bringing machine 'wordpress' up with 'docker' provider...
==> cron: Building the container from a Dockerfile...
    cron: Image: 5fcdcf71d26c
==> cron: Creating the container...
    cron:   Name: cron
    cron:  Image: 5fcdcf71d26c
    cron: Volume: /var/www/owncloud
    cron: Volume: /home/USER/workspace/vagrant-cron:/vagrant
    cron:
    cron: Container created: 5d52f278e735cddf
==> cron: Starting container...
==> cron: Provisioners will not be run since container doesn't support SSH.
```
