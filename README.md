# nmfs-jhub

## Images 

Base Python image is **openscapes/python** ![](https://img.shields.io/docker/image-size/openscapes/python/f577786
)
<a href="https://hub.docker.com/repository/docker/openscapes/python:f577786"><img src="https://img.shields.io/badge/version-f577786-blue"></a>

In ci folder and on DockerHub

**iopython (Openscpaes Python+tensorflow)**: ![](https://img.shields.io/docker/image-size/eeholmes/iopython?sort=date)
<a href="https://hub.docker.com/repository/docker/eeholmes/iopython/tags?page=1&ordering=last_updated"><img src="https://img.shields.io/docker/v/eeholmes/iopython"></a>

**iorocker (Openscpaes Python+R)**: ![](https://img.shields.io/docker/image-size/eeholmes/iorocker?sort=date)
<a href="https://hub.docker.com/repository/docker/eeholmes/iorocker/tags?page=1&ordering=last_updated"><img src="https://img.shields.io/docker/v/eeholmes/iorocker"></a>

## JupyterHubs

I have set us up a JupyterHub Python/JupyterNotebook & R/RStudio cloud-computing site on Azure. Its on Kubernetes and will spin up VMs as needed. 

Vanilla: https://jhub.opensci.live/hub/login. The VMs are not huge: 2CPU & 8 Gig RAM (testing hub)

daskhub: https://dhub.opensci.live/hub/login. The VMs are not huge: 4CPU & 32 Gig RAM (production hub)


Login via GitHub. Contact Eli if you want access to test.

Instructions for the test hub https://jhub.opensci.live/hub/login: It should be pretty self-explanatory.

* Chose Python or R
* It is based on the Openscapes Docker images and is fairly full-featured but during testing let me know any libraries you need loaded.
* Does your work persist? Yes. It should be like your computer.
* Is there a limit to storage? Yes. I don't know what it is. Go ahead an use it so I can get a sense of storage needs.
* How do I link to my GitHub repositories? Follow these instructions https://snowex-2022.hackweek.io/preliminary/git.html

Post any comments in the discussion so we all can follow them.

## Setting up Git to remember you

Basically

1. Open up a terminal
```
git config --global user.name "Your Name"
git config --global user.email "yourname@your.com"
git config --global credential.helper store
```

2. Make a PAT on GitHub

3. Head back to the JupyterHub and do a push. It'll ask for your username and password. After that it will remember.

## What a JupyterHub

Read about why cloud compute environments are great. This one is the same as the SnowEx Hackweek one except that it also has RStudio server: https://snowex-2022.hackweek.io/preliminary/jupyterhub.html



