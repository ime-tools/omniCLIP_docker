FROM ubuntu:latest

MAINTAINER Daniel Amsel "daniel.amsel@ime.fraunhofer.de"
 

WORKDIR /opt/

RUN apt update && apt install --yes git 
	python \
	wget \
	python-pip \
	python-numpy

RUN git clone https://github.com/philippdre/omniCLIP.git

RUN pip install --upgrade pip

RUN pip install biopython \
	brewer2mpl \
	cython \
	gffutils \
	h5py \
	intervaltree \
	matplotlib \
	pandas \
	prettyplotlib \
	pysam \
	scikit-learn \
	scipy \
	statsmodels

WORKDIR /opt/omniCLIP/stat/

RUN ./CompileCython.sh

RUN  rm -rf /var/lib/apt/lists/*

WORKDIR /data/
