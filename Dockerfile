FROM jupyter/scipy-notebook:latest
# FROM cschranz/gpu-jupyter

LABEL author="Tuple, LLC <contact@tuple.xyz>"
USER root

## Copy EquiBind Resources
RUN mkdir /equibind
COPY . /equibind

WORKDIR /equibind

## Environment Settings
ENV DEBIAN_FRONTEND=noninteractive \
    JUPYTER_ENABLE_LAB=yes \
    JUPYTER_TOKEN=equibind \
    NB_USER=equibind \
    CHOWN_HOME=yes \
    GRANT_SUDO=yes \
    RESTARTABLE=yes \
    SETUPTOOLS_USE_DISTUTILS=stdlib

## Install Basic Dependencies
RUN apt-get clean && \
    apt-get update && \
    apt-get -y install \
        git \
        curl \
        wget \
        python3.9

## Install EquiBind Dependencies
RUN conda init bash
# RUN conda env create -f environment.yml
RUN conda env create -f environment_cpuonly.yml

# CMD conda activate equibind


RUN sudo chmod -R 777 /equibind
