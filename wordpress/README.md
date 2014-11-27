# Wordpress Container
This vagrant file is to be used with php-fpm container setup on [vagrant-phpfpm](https://github.com/jlope001/vagrant-phpfpm).

## Why data container
In order to properly host assets and execute PHP files, you will need data shared between both php-fpm and nginx containers.

This will give us two advantages:
  * Remove duplication of services
  * Remove deplication of data (this container)

This will allow you to install alongside a php-fpm container + nginx container.

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
==> wordpress: The container hasn't been created yet.
Bringing machine 'wordpress' up with 'docker' provider...
==> wordpress: Building the container from a Dockerfile...
    wordpress: Image: 5fcdcf71d26c
==> wordpress: Creating the container...
    wordpress:   Name: wordpress
    wordpress:  Image: 5fcdcf71d26c
    wordpress: Volume: /var/www/wordpress
    wordpress: Volume: /home/USER/workspace/vagrant-wordpress:/vagrant
    wordpress:
    wordpress: Container created: 5d52f278e735cddf
==> wordpress: Starting container...
==> wordpress: Provisioners will not be run since container doesn't support SSH.
```
