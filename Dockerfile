FROM ubuntu:latest

MAINTAINER Pedro Hernandez <p.hernandezserrano@maastrichtuniversity.nl>

RUN apt-get update && \
    apt-get -y install wget python-pip python2.7 python-dev python-matplotlib libblas3 liblapack3 libstdc++6 python-setuptools && \
    apt-get clean && \
    pip install --upgrade pip && \
    pip install turicreate ipython "ipython[notebook]" jupyter && \
    mkdir /root/notebooks

WORKDIR /root/notebooks

EXPOSE 8888

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--allow-root", "--ip=0.0.0.0"]
