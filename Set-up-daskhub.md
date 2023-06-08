Setting up a multi-user JupyterHub with Dask enabled.

# Log into portal.azure.com

1. Get to the dashboard that looks similar to this.

<img width="1161" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/ef8ad54f-6666-435f-bf03-c70b269dd189">

2. Click on the Kubernetes Services button and you should see something like this

<img width="1389" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/7a1d97be-65e7-41a0-9a41-c3b768366c81">

3. Click Create Kubernetes Cluster

At this point, you will get to the set-up with lots of tabs. 

* You need to select the resource group if you are in a subscription for an organization. Don't know what resource group to use, ask the admins.
* You need to give your Kubernetes cluster a name. For example, `jhub` or `daskhub` or whatever.
* You need to chose the AWS region. If you are using AWS S3 file access (big data in the cloud), then you need to be on the same region as the files you are accessing. Do you have no idea? Then you are probably not using AWS S3 file access. In that case, just go with the default or something close to you.
* Next you chose the "Node size". This is the size of the base virtural machine (VM). It is going to spin up as many as it needs. The default is [Standard DS2 v2](https://azureprice.net/vm/Standard_DS2_v2) which as 2 CPU, 7 Gig RAM and 1T memory. This is fine for set-up. You can change it later. Accept auto-scaling since this is a multi-user hub.

The first tab is all you need for now. Later you may want to allow the user, to choose a different base VM. You can do that by adding node-pools. That'll be covered after the initial set-up. For now, just get your basic hub working. You can add more VM sizes later.

4. Click "Review and Create"

Wait for validation tests to pass.

5. Click "Create".

Once it is done deploying, you will see this.

<img width="1024" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/f2354ee2-8351-4fdd-a773-24ee381228a1">





# Step 2 Create a domain name

You will need a domain name for `https::` which you want. 

* Find a domain name provider and set one up. It is not expensive. I used GoDaddy.  Let's pretend you set up `bluemountain123.live` as the domain.
* Go to the DNS settings for your domain. Add a type A record. This will do 2 things. First this will create the subdomain that you will use to access your JupyterHub. So let's say you create, `jhub` as the type A DNS entry. Then `jhub.bluemountain123.live` will be the url. You can have as many subdomains as you need.
