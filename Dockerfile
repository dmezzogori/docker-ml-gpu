
FROM nvidia/cuda:11.0-base

ARG PYTHON_VERSION=3.9
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev && \
     rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION \
     numpy=1.19.1 \
     pandas=1.1.2 \
     matplotlib=3.2.1 \
     scipy=1.5.2 \
     jupyter=1.0.0 \
     mkl=2020.2 \
     mkl-include=2020.2 \
     scikit-learn=0.23.2 \
     cudatoolkit=11.0 &&\
     #tensorflow-gpu=2.4.0 && \
     /opt/conda/bin/conda install -y pytorch=1.7.0 torchvision -c pytorch -c=conda-forge && \
     /opt/conda/bin/conda clean -y --all

ENV PATH /opt/conda/bin:$PATH

RUN useradd -ms /bin/bash davide
USER davide

WORKDIR /home/davide/workspace
