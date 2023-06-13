Setting up a multi-user JupyterHub with Dask enabled.

# Create your Kubernetes cluster

Log into `https:\\portal.azure.com`

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

# Install DaskHub on your cluster

These next steps are done in the shell after connecting to your cluster. First you need to get to the shell.

## Connect to your cluster

Once you have created your Kubernetes cluster, you want to go to its dashboard (by clicking on the name you gave it). You'll see something like this (I named mine `daskhub`).

<img width="1090" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/3fb0142a-7b96-4695-ae72-e95e7aeddc18">

Click on the Connect icon: <img width="93" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/83391400-327c-4e85-b18f-dd0b4f45174c">

You then see this 

<img width="578" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/ea6259fd-62c3-4115-b222-5fe8a74b2dfd">

Click on the link that says "Open Cloud Shell".

<img width="924" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/70a5ba99-edb0-4cc6-bb7b-80af82e11590">

You will get to a terminal. Paste in the two commands in the previous image (the commands that show up for you that is).

## Create `dconfig.yaml`

This will be the configuration file for your Dask-enabled JupyterHub. For now, it can be just comments. Note the name is unimportant but should end in `.yaml`. I am using `dconfig.yaml` instead of `config.yaml` since I already have a `config.yaml` file for something else.

```
nano dconfig.yaml
```
This will open the nano editor. Edit your file. You can do `# just blank for now`. Then `Cntl-O` to save and `Cntl-X` to exit.


## Install daskhub via helm chart

Instructions: https://artifacthub.io/packages/helm/dask/daskhub .

Check that helm is installed
```
helm version
```
Tell helm about the dask helm repository
```
helm repo add dask https://helm.dask.org
helm repo update
```

Now install
```
helm upgrade --wait --install --render-subchart-notes \
    dhub dask/daskhub \
    --namespace=dhub --create-namespace \
    --values=dconfig.yaml
```
You will see this on successful installation (it's long. much has been cut).
<img width="820" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/4540dc50-6c3d-42c5-be13-e54c4baa08f5">

## Set-up your external IP address

```
kubectl config set-context $(kubectl config current-context) --namespace dhub
kubectl --namespace=dhub get service proxy-public
```
![image](https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/15f7060c-b6a2-4c7b-81b5-554f34a0f91f)

Save the IP address. You will need it in step 2. Look for the IP address under `EXTERNAL-IP`.


# Step 2 Set up https

You can log out of your cluster. The next steps are done elsewhere. 

## Create a domain name

You will need a domain name for `https` which you want for security (and JHub won't stop complaining if you don't). Find a domain name provider and set one up. It is not expensive. I used GoDaddy.  

## Create a DNS entry

Let's pretend you set up `bluemountain123.live` as the domain. Go to the DNS settings for your domain. Add a type A record. This will do 2 things. First this will create the subdomain that you will use to access your JupyterHub. So let's say you create, `dhub` as the type A DNS entry. Then `dhub.bluemountain123.live` will be the url. You can have as many subdomains as you need.

<img width="813" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/4e99d678-3c89-4a5c-b617-c220729ddbc1">

## Test if the url is working

`dhub.bluemountain123.live` using the example would be the url. Test that it is working (shows a JupyterHub login) before moving on. This is what you should see:

<img width="378" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/1d71683f-9c8d-4f9b-ae79-dfa0a5c86712">

## Set-up https on your JupyterHub

[Read documentation](https://tljh.jupyter.org/en/latest/howto/admin/https.html) Log back into your cluster. Got to portal.azure.com, click on your Kubernetes cluster name, and then click on "Connect". Then click on "Cloud Shell".

Once you are on the shell, type

```
nano dconfig.yaml
```
to edit the config file. Paste this in and save. Note the additional `jupyterhub:` in the yaml file. This is not in a plain JupyterHub with Kubernetes config file.
```
juptyerhub:
  proxy:
    https:
      enabled: true
      hosts:
        - dhub.opensci.live
      letsencrypt:
        contactEmail: eli.holmes@noaa.gov
```

## Update the JupyterHub installation

```
helm upgrade --cleanup-on-fail --render-subchart-notes dhub dask/daskhub --namespace dhub --version=2023.1.0 --values dconfig.yaml
```

## Test if https is working

Try `https:\\dhub.bluemountain123.live`

# Step 3 Set up GitHub authentication

Optional, if you want to manage who can login via GitHub. I am going to show an example where I use a team on a GitHub organization to manage authentication. There are many other ways to manage users. Google to find that.

## Create a new Oauth Application on GitHub

This is going to be associated with your GitHub account, but you can use a team on a GitHub org.

Log into GitHub and go to GitHub > Settings > Developer Settings > New Oauth Application

<img width="625" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/0e176cc5-0fe2-4960-9a5e-31d6db92f812">

Next you will see something like this
<img width="812" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/96f4a440-ebb2-49c5-8888-25d7e81b6eb4">

## Create a team in your GitHub org

You will be added by default and add anyone else who needs access to the hub.  Let's say your org is `MyOrg` and the team is called `DaskHub`. So then the allowed organization is MyOrg:DaskHub. You can leave off `:DaskHub` if you want to allow all members of the organization to log in.

## Edit the `dconfig.yaml` file

```
nano dconfig.yaml
```
Add to your config file so it is now this. Replace the id, secret and url with your values.
```
jupyterhub:
  hub:
    config:
      GitHubOAuthenticator:
        client_id: <replace with your OAuth id>
        client_secret: <replace with your OAuth app secret>
        oauth_callback_url: https://<your url>/hub/oauth_callback
        allowed_organizations:
          - MyOrg:DaskHub
        scope:
          - read:org
      JupyterHub:
        authenticator_class: github
  proxy:
    https:
      enabled: true
      hosts:
        - <your url>
      letsencrypt:
        contactEmail: eli.holmes@noaa.gov        
```

## Update the hub

```
helm upgrade --cleanup-on-fail --render-subchart-notes dhub dask/daskhub --namespace dhub --version=2023.1.0 --values dconfig.yaml
```

## Test

You should now see this and can authenticate with GitHub.

<img width="221" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/4e8f72d3-9e38-4490-b2fa-57254a6801ce">













