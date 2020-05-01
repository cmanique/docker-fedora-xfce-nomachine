# Docker Alternative to Virtual Machines for Transient Environments That Require GUI's

A Fedora based Docker image with Xfce4 and NoMachine which allows for local Virtual Machine equivalent graphical performance (as opposed to X11, VNC and RDP), accessing the desktop environment.

> **DISCLAIMER**: so far this has been tested on Windows 10 64bit host, which is the platform that lacks the most in terms of graphical connectivity to remote environments other than native remote desktop connections, or virtual machines working in seamless mode, that come at a great cost of storage space, and don't have the modular capabilities of docker.
> 
> I do have reasons to believe that if a display is already running on the host (ie: Linux, Mac), maybe NoMachine will show it instead. Needs investigation. I did test on headless remote Linux and it works just as fine (just slower due to network latency)

## How use

### a) Build the image from this repository

```
$ git clone https://github.com/cmanique/docker-fedora-xfce-nomachine.git
$ cd docker-fedora-xfce-nomachine
docker build -t fedora-xfce-nomachine .
```   

### b) Directly from Docker Hub

```
$ docker pull cmanique/fedora-xfce-nomachine
```

### Start a container

```
$ docker run --cap-add=SYS_PTRACE -d -p 4000:4000 --name fedora-xfce-nomachine cmanique/fedora-xfce-nomachine
```

> note the container needs to be run as a daemon (unless you want it to run privileged, and it's pointless because of the entrypoint)

### Bash into the container with docker exec

```
$ docker exec -it fedora-xfce-nomachine bash
```

### Start the NoMachine server

```
$ /usr/NX/bin/nxserver --startup

NX> 111 New connections to NoMachine server are enabled.
NX> 161 Enabled service: nxserver.
NX> 162 WARNING: Cannot find X servers running on this machine.
NX> 162 WARNING: A new virtual display will be created on demand.
NX> 161 Enabled service: nxd.
```

### Download NoMachine

Open https://www.nomachine.com/download on your browser and download the appropriate installer (Windows, Mac, Linux)

### Install NoMachine on your Docker **host**

Follow the instructions at https://www.nomachine.com/DT02O00124 in order to correctly install the software on your computer

### Start the NoMachine Client and Create a New Connection

![alt](../media/readme-001-nomachine-new.jpg?raw=true)

### Choose **NX** as protocol and click **Continue**

![alt](../media/readme-002-nomachine-protocol.jpg?raw=true)

### Ensure the default values are appropriate and click **Continue**

![alt](../media/readme-003-nomachine-host.jpg?raw=true)

### Ensure authentication is set to **Password** and click **Continue**
![alt](../media/readme-004-nomachine-authentication.jpg?raw=true)

### Ensure **Don't use a proxy** is selected and click **Continue**
![alt](../media/readme-005-nomachine-proxy.jpg?raw=true)

### Name your connection accordingly and click **Done**
![alt](../media/readme-006-nomachine-saveas.jpg?raw=true)

### **Double-click** the newly created connection
![alt](../media/readme-007-nomachine-connect.jpg?raw=true)

### Enter the **Username** and **Password**, optionally save the credentials and click **OK**
![alt](../media/readme-008-nomachine-unp.jpg?raw=true)

> for the time being the credentials are hard-coded on the Dockerfile as nomachine/nomachine

### Tick **Always create a new display on this server** and click **Yes**
![alt](../media/readme-009-nomachine-createdisplay.jpg?raw=true)

### Tick **Mute audio on the server while I'm connected", "Don't show this message again for this connection", select the second icon on the bottom row in order to resize the remote display to your window and click **OK**
![alt](../media/readme-010-nomachine-audio.jpg?raw=true)

### Enjoy your Fedora Xfce Desktop
![alt](../media/readme-011-nomachine-fullscreen.jpg?raw=true)

> this case shows Red Hat CodeReady Studio, which was also installed through Docker, by having an image extending this one

### Stop the container

```
$ docker stop fedora-xfce-nomachine
```