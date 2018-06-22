# Machine Learning Use Cases

![Docker](https://img.shields.io/badge/docker%20build-not%20auto-blue.svg)

Disclaimer: All of the data are either totally public or made up, it turns out they are not for any commercial purpose.

- Here you can find nice notebooks with machine learning use cases built on [turicreate](https://github.com/apple/turicreate) `0.11.0`
- There is also available the notebooks used on machine learning course of [ITAM Data Sciene](http://mcienciadatos.itam.mx/es)
- Turicreate is the new version of graphlab create library, in the meantime certain modules as `shows` or any visualization are only available on macOS, to know more [here](https://github.com/apple/turicreate)

## Usage

Install [Docker](https://www.docker.com/) then go to your shell and verify is well installed `docker -h`

Clone this repository

    git clone https://github.com/pedrohserrano/machine-learning-use-cases.git && \
    cd machine-learning-use-cases/

Build the Docker image

    docker build -t ml/turicreate .

Run the container

    docker run -it -p 8888:8888 -v "$PWD":/home/jovyan --name=turi ml/turicreate

Note: When you run the container the notebook is going to be activated, so you have to access the link is pop up on the console

    http://0.0.0.0:8888/?token=<SOME-RANDOM-TOKEN-SHOWED-IN-CONSOLE>

To exit the container simply exit the kernel (after save your results) `ctrl + c` then to activate the container again

    docker start -ai turi

## Optional

It's possible to run a complete environment with different kernels, more info [here](https://github.com/jupyter/docker-stacks/tree/master/datascience-notebook), note that this environment does not content turicreate.

    docker run -it -p 8888:8888 -v "$PWD":/home/jovyan --name=jupyterlab jupyter/datascience-notebook start.sh jupyter lab