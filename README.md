# Giada-docker

This is the official Docker image for [Giada Loop Machine](https://giadamusic.com/). We baked it with much love to ease the compilation + testing process. No more cluttering up your environment and hunting for dependencies that are nowhere to be found: everything is shipped within the image you are going to download from the Docker Hub.

This is just one of many potential workflows available through Docker. Is this solution perfect? Definitely not. We love your feedback, so please help us making it more and more awesome :heart_eyes:.

## What you need

* Docker
* Git

## Prepare the workbench

Make sure you have Docker and Git installed. When you are ready, clone the [Giada repository](https://github.com/monocasual/giada) somewhere in your file system:

`$ git clone git@github.com:monocasual/giada.git`

Now pull the Docker image from [our Docker Hub repository](https://hub.docker.com/u/monocasual/):

`$ docker pull monocasual/giada-docker`

## Run the Docker container

We are going to create and run a container called "giada" from the image you've just downloaded, with UI and audio support :sunglasses:. This is the full command:

```
$ docker run \
--rm \
-i -t \
-v $(pwd):/home/giada/build \
-v $HOME:/root \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/shm:/dev/shm \
-v /etc/machine-id:/etc/machine-id \
-v /run/user/$(id -u)/pulse:/run/user/$(id -u)/pulse \
-v /var/lib/dbus:/var/lib/dbus \
-v $HOME/.pulse:/home/root/.pulse \
-e DISPLAY \
--privileged \
--name "giada" \
monocasual/giada-docker 
[commands here]
```

Make sure you are running it inside the directory of the cloned repository.

We usually wrap the command inside a Bash script or an alias like `giadaDocker`, for brevity's sake. 

## Configure, make and run Giada

From now on you can follow the traditional steps for building Giada from source. For example:

```
$ giadaDocker ./configure --target=linux [more configure parameters here]
$ giadaDocker make
$ giadaDocker ./giada
```

The configure script takes additional parameters, such as the VST plug-in enabler or the debug mode. Take a look at the [official documentation page](https://www.giadamusic.com/documentation/show/compiling-from-source) for the complete reference.

Enjoy!

## Caveats

Currently only Pulseaudio is supported. We are working on the ALSA and Jack counterparts.