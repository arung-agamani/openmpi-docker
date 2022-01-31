# OpenMPI on Docker
Run MPI programs inside Docker.
This repository describes a Dockerfile and docker-compose.yml for creating Docker images enhanced with MPI-related toolsets (compiler, runner).
It uses Ubuntu 20.04 as the base image, so make sure your program can run on it first.

## Motivation
Sometimes it's just hard to test out MPI programs on multiple nodes, as it requires multiple machines. It's also not that cheap to spawn VM instances on cloud service or even on local machine using something like VirtualBox or VMWare.

The pain has been (or trying to be) eliminated by using Docker as it really can spawn lightweight virtual machines that can run almost any tasks as it really runs on a real machine. Of course, it's limited to CPU-only tasks as it's pretty tricky to access GPU devices (which could be the future development of this repo), but it's better than nothing, eh?


# Usage
## Requirements
- Any Linux environments (Native or WSL2)
- Docker (Docker Desktop on WSL)
***
## How To
This repository is composed by several phases, and needs to be executed in order to prevent misconfiguration.

### 1. Generate SSH Key
We will need to create a SSH keypair that will be used by the containers to login to each other, and for us to login into the head/master container.
Simply run `generate_ssh_key.sh` using BASH and it will output your keys under `.ssh` folder relative to this repository's directory (that, if you run it here, in the same directory of this readme).

### 2. Write down your MPI program
A sample Hello World MPI program has been put here. You can just use the same file and fill it with your MPI program, or use other files or even add more files.

### 3. Adjust Dockerfile to your case
The current Dockerfile described will put the current MPI program source code into the image and compile it inside. In case you need to put external data to process, or your program involves multiple source file, then you need to adjust the compilation parameters of `mpicc`, and put the data inside also.
You can refer to `ADD` and `RUN` directives of Dockerfile to start.

### 4. Build Dockerfile
Run `docker build -t convenient_name/convenient_container_name .` to build the docker image. Just use convenient tag name for easier handling.

### 5. Configure and Run Docker Compose
The name of your image will be referenced inside `docker-compose.yml`. Make sure you put the exact value on `image` attribute of both services. After that, run the compose project using `docker-compose up -d`. It will listen to port 6699 that will be forwarded to port 22 (SSH) of the head/master container. You'll SSH into this container later.

### 6. Connect to master/head container and execute your MPI program.
SSH into the head/master container using
`ssh -i [path to your generated ssh keyfile] -p [port number] [username]@localhost`
Replace those in square brackets with the right value/part to the respective resource. Once logged in, execute `fetch_hostnames.sh` to prepare the hostfile.
By this, you can simply run `mpirun -hostfile mpi_hostname [name of your MPI program]`

If nothing goes wrong, you should be able to see the output in your terminal.

***

## Future Ideas/Plans
- Add support for external data fetching and/or external MPI program source.
- Add support for GPU


## About
Made with tears and sweats by Arung Agamani Budi Putera