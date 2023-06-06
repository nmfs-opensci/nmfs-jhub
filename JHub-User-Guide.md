# Instructions

## Login

https://jhub.opensci.live/hub/login

You will see this. Choose Python for Python only; choose R for Python and R.

<img width="861" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/5dfee495-b26c-4cc0-96d0-69ebcae98d7d">

## Spin up your server

You will see this as your server spins up

<img width="1307" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/7285341d-0f04-4b4c-8a1a-76237efbcba3">

## Choose your platform

You can code in RStudio, JupyterLab or Terminal.

<img width="563" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/fe775c38-cb36-45bf-8ce5-c797d73d8f1f">

## Let's choose RStudio

<img width="1426" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/a75b2d1e-06fc-4276-96fe-def19827c99b">

### Clone a repo

Choose 'new project' (top right) and Version Control.

<img width="542" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/9f2d7b27-4f51-4678-b0b2-4b8db0e3ec09">

### Tell Git who you are 

Tell Git who you are and save your authentication info. You only do this once (or until your
PAT expires). Run this code from the R console (not terminal).

```
usethis::use_git_config(user.name = "YourName", user.email = "your@email.com")
```
Now create a personal access token for authentication.  SAVE the token because you will need it in the next step.
```
usethis::create_github_token() 
```
Now run this and paste in the token.
```
gitcreds::gitcreds_set()
```
Restart R. You can chose your project from the dropdown on the top right to do this.

Now commit a change and push.

*Note, you can also run the commands below from a terminal window.*

## Let's choose JupyterLab

Any of the browser tabs with this icon are JupyterLab <img width="37" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/65af5d1b-9382-4c2e-a058-df32c6059350">

Be careful because you can be in RStudio with one GitHub repository and you could open the same repo in JupyterLab and easily create merge
conflicts. Just be aware that they are in separate file systems so changes on RStudio will not be reflected in JupyterLab. It is
not like you are on one computer.

### Tell Git who you are

*But I just did that with RStudio!* I know but the JLab instance is in a different environment and doesn't know what you did in the 
RStudio environment.

Open a terminal. You do this from the Launcher window. You can always open a new launcher window by clicking the little + tab

<img width="458" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/51b5004f-d616-4b1c-84e2-ab0b62da9d52">

Now click Termnal

<img width="674" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/7fcb9c64-d56e-4b02-b085-e02ceab54264">

* Run this code

```
git config --global user.name "YourName"
git config --global user.email "your@email.com"
git config --global credential.helper store
```

* Create a PAT or use the one you created for RStudio

* Make a commit and push with the PAT as the password. Now you are set (until your PAT expires).

### Clone a Git repo

Click the Git icon on the left and you can clone a repo.

<img width="327" alt="image" src="https://github.com/nmfs-opensci/nmfs-jhub/assets/2545978/05c252f4-a76f-4ff7-b7f1-3a8d3d097b9f">

## Stop your server

It will stop on it's own after awhile, but if it hangs, you can stop it and restart it. With File > Hub Control Panel



