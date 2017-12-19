# Machine Learning Use Cases

Disclaimer: All of data are either totally public or made up, it turns out they are not for any commercial purpose.

- Here you can find nice notebooks build on turicreate
- There's also available the notebooks used on ML course of ITAM Data Sciene

## Usage

Clone this repository 

        git clone https://github.com/pedrohserrano/machine-learning-use-cases.git && \
        cd machine-learning-use-cases/

Build the Docker image

        docker build -t ml/turicreate .

Run the container

        docker run -it -p 8888:8888 -v "$PWD"/notebooks:/root/notebooks/ --name=gl_box graphlab

Note: When you run the container the notebook is going to be activated, so you have to access the link is pop up in the console

        http://0.0.0.0:8888/?token=<SOME-RANDOM-TOKEN>

