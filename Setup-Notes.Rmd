# Instructions for editing config

1. Log into https://portal.azure.com/ and once successful, you will see this

<img width="1176" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/bcd44875-a5bc-49e0-b047-638b7747c1ae">

2. Click the JupyterHub icon and you will see this

<img width="815" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/99c0cac0-7e65-444a-8b95-b0377db1ec4a">

3. Click the Connect icon and you will see this. Ignore everything else that you see. I don't think you need to run the `kubectl get deployments --all-namespaces=true` unless you need to check Kubernetes set up.

<img width="247" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/686f64b0-f5ef-47b7-addd-0f8ddbc0455c">

4. Type `nano config.yaml` to get the the JupyterHub config. This is the only file you need to change. cntl-O to write. cntl-X to exit.

After you update the `config.yaml`, you need to tell the JupyterHub about the change

```
helm upgrade --cleanup-on-fail jhub jupyterhub/jupyterhub --namespace jhub  --version=2.0.0 --values config.yaml
```

If upgrade was successful, you will see this (plus a bunch of text below that you can ignore).

<img width="797" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/d632c4ed-e9a0-49df-b0a3-433a2778bb03">

5. What a few minutes for your changes to take effect.
