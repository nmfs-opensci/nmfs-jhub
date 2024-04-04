---
title: "Set up JupyterHub on AWS"
description: |
  Setting up JupyterHub on AWS (Amazon Web Services)
---

## Background

  - Jupyter AWS setup instruction: [https://saturncloud.io/blog/jupyterhub_aws/](https://saturncloud.io/blog/jupyterhub_aws/)
  - Documentation:  [https://z2jh.jupyter.org](https://z2jh.jupyter.org)
  - Help forum:     [https://discourse.jupyter.org](https://discourse.jupyter.org)
  - Issue tracking: [https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues](https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues)
  
See examples of full `config.yaml` files in the `config` directory in the [nmfs-opensci/nmfs-jhub](https://github.com/nmfs-opensci/nmfs-jhub) GitHub repo.

## Set-up Amazon Web Services (AWS)

1. Create a AWS account. 

2. Create VPC (Virtual Private Cloud) from AWS Cloud Formation using VPC template from the Jupyter AWS setup instruction or  [amazon-eks-vpc-private-subnets.yaml](amazon-eks-vpc-private-subnets.yaml)

3. Create IAM (Identity Access Management) user and roles  
  * user to access the system using `aws cli`
  * EBS (Elastic Block Storage) role  
  * EKS (Elastic Kubernetes Service) role
  * cluster node group role

:::{.callout-warning title="Note"}
the IAM user and roles are created to interact with AWS resources.  Appropriate policies must be added to the IAM roles.
:::

## Set-up Kubernetes cluster

1.  Create AWS EKS cluster with Add-on __AmazonEBS__

2.  Create node group with min and max number of nodes

3.  Add crediential of IAM user to a machine you are connecting from and connect to the cluster

```
export AWS_ACCESS_KEY_ID=[YOUR_ACCESS_KEY_ID]
export AWS_SECRET_ACCESS_KEY=[YOUR_AWS_SECRET_ACCESS_KEY]
export AWS_DEFAULT_REGION=[YOUR_REGION]

aws sts get-caller-identity
aws eks update-kubeconfig --region [YOUR_REGION] --name [YOUR_CLUSTER_NAME]
```

5. Check cluster
```
kubectl get svc  # get a list of services in the kubernetes clusteer
Kubectl get node  # get a list of nodes in the cluster
```

## install helm 3

Install and check version installed.

```
curl https://raw.githubusercontent.com/helm/helm/HEAD/scripts/get-helm-3 | bash
helm version
```

Set up the `config.yaml` file. Just dummy for now.

```
nano config.yaml
```

Copy this in and then Cntl-O and return to save and then Cntl-X to exit

```
# Chart config reference:   https://zero-to-jupyterhub.readthedocs.io/en/stable/resources/reference.html
# Chart default values:     https://github.com/jupyterhub/zero-to-jupyterhub-k8s/blob/HEAD/jupyterhub/values.yaml
#
```

## Install JupyterHub

Add the repository where we will install from.
```
helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
helm repo update
```

Install
```
helm upgrade --cleanup-on-fail \
  --install jhub1 jupyterhub/jupyterhub \
  --namespace jhubk8 \
  --create-namespace \
  --version=3.3.4 \
  --values config.yaml
```

The variables: `jhub1` is the name of the JupyterHub. You could have many on this Kubernetes cluster. We will only have 1 however. `jhubk8` is the namespace of all the assets that will be associated with this JupyterHub. All your storage (pvc) will appear in this namespace and you will have to add `--namespace jhubk8` to commands where you are trying to list or debug assets (like storage or killing nodes that are stuck). `config.yaml` is the file that has all the configuration settings.

## Connect to the JupyterHub

Now it is running. Let's try connecting via IP address

```
kubectl --namespace jhubk8 get service proxy-public
```
Will show you the public IP address. You should be able to go to that and log in with any username (no password).

## Set-up https

This will be required for setting up authentication and also security.

### Create a domain name

Find a domain name provider and set one up. It is not expensive. I used GoDaddy.

### Create a DNS entry

Let's pretend you set up `bluemountain123.live` as the domain. Go to the DNS settings for your domain. Add a type A record. This will do 2 things. First this will create the subdomain that you will use to access your JupyterHub. So let's say you create, `dhub` as the type A DNS entry. Then `dhub.bluemountain123.live` will be the url. You can have as many subdomains as you need.

![](../images/img8.png)

### Test if the url is working

`http:\\dhub.bluemountain123.live` would be the url using the example domain above. Test that it is working (shows a JupyterHub login) before moving on. This is what you should see:

![](../images/img9.png)

### Set-up https on your JupyterHub

Log back into your Kubernetes cluster, by going to your project on Google Cloud and clicking the Cloud Shell icon in the top right (box with `>_`). Once you are on the shell, type

```         
nano config.yaml
```

Paste this in and save (Cntl-O, return and then Cntl-X to exit). The `traefik` bit is specific to GCP. Often people have trouble with GCP cluster spinning up too fast and it can't find the letsencrypt certificate. A small delay prevents that problem. This is just for GCP. I never had that problem on Azure.

```         
proxy:
  traefik:
    extraInitContainers:
      # This startup delay can help the k8s container network find the 
      # https certificate and allow letsencrypt to work in GCP
      - name: startup-delay
        image: busybox:stable
        command: ["sh", "-c", "sleep 10"]
  https:
    enabled: true
    hosts:
      - dhub.bluemountain123.live
    letsencrypt:
      contactEmail: yourname@gmail.com
```

### Update the JupyterHub installation

Anytime you change `config.yaml` you need to run this code. Replace the variables (like `jhub1`) with your names. `jupyterhub/jupyterhub` is specific to the helm chart; don't change that. 

```         
helm upgrade --cleanup-on-fail   --install jhub1 jupyterhub/jupyterhub   --namespace jhubk8   --create-namespace   --version=3.3.4   --values config.yaml
```

### Test if https is working

Try `https:\\dhub.bluemountain123.live` and you should see the JupyterHub login without that http warning.

## Set up authentication

See the post on [setting up authentication](set-up-authentication.html) for instructions.

## Deleting the Kubernetes cluster

* Go to EKS Console
* Select the cluster and delete all associated node groups
* Once node groups are deleted, then delete the cluster
* Wait awhile and make sure all the associated VMs and storage are deleted. 
* Go back onto billing in a few days and make sure it is not charging you. If it is, something associated with the JHub didn't get deleted.

## Post-installation checklist

* Verify that created Pods enter a Running state: `kubectl --namespace=jhubk8 get pod`
* If a pod is stuck with a Pending or ContainerCreating status, diagnose with: `kubectl --namespace=jhubk8 describe pod <name of pod>`
* If a pod keeps restarting, diagnose with: `kubectl --namespace=jhubk8 logs --previous <name of pod>`
* Verify an external IP is provided for the k8s Service proxy-public. `kubectl --namespace=jhubk8 get service proxy-public`
* If the external ip remains <pending>, diagnose with: `kubectl --namespace=jhubk8 describe service proxy-public`
