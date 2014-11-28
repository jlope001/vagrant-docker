# Dockerfile Vagrant Gitolite
Setup your own personal git server with access restrictions.

## Gitolite
According to gitolites homepage, "Gitolite allows you to setup git hosting on a central server, with fine-grained access control and many more powerful features."

More information can be obtained from their [homepage](http://gitolite.com/).

## Vagrant + Docker
I use [vagrant](http://www.vagrantup.com/) and I love it.  Vagrant allows you create development environments via virtual machines.  Vagrant makes use of Docker by building the machines with Docker.  Docker does not create a VM but a light weight linux container.

Read more about Docker [here](https://www.docker.com/), its amazing.

## Setup
### Requirements
You will need docker and vagrant installed on your system.

### Environment Variables
Instead of storing sensitive information in this public repository, I make use of environment variables that you pass in.

The one variable you will need to set is GIT_ID_RSA_PUB.  You will need to push over your pub key there.  gitolite needs to know what user to allow connections from.

```
export GIT_ID_RSA_PUB="`cat ~/.ssh/id_rsa.pub`"
```

### Build the container
Creating the container is a simple as running vagrant up.

```
$ vagrant up
```

You should see something built out:

```
$ vagrant up
Bringing machine 'git' up with 'docker' provider...
==> git: Building the container from a Dockerfile...
    git: Image: 96db3248f4a3
==> git: Creating the container...
    git:   Name: git
    git:  Image: 96db3248f4a3
    git: Volume: /home/USER/workspace/vagrant-git-server:/vagrant
    git:   Port: 6000:22
    git:
    git: Container created: cc16c0e05e1a5cd6
==> git: Starting container...
==> git: Provisioners will not be run since container doesn't support SSH.
```

Once completed, run the following command to verify all is well:

```
$ git clone ssh://git@localhost:6000/testing.git
Cloning into 'testing'...
warning: You appear to have cloned an empty repository.
Checking connectivity... done.
```
