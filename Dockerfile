ARG baseimage_version=xenial
FROM ubuntu:${baseimage_version}

ARG version=master
ARG VCS_REF
ARG BUILD_DATE

RUN echo "VCS_REF: "${VCS_REF}", BUILD_DATE: "${BUILD_DATE}", branch: "${version}

LABEL maintainer="daniel.amsel@ime.fraunhofer.de" \
      description="Container for the omniCLIP package" \
      version="v0.1.0" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ime-tools/omniCLIP_docker"

WORKDIR /opt/

RUN apt update && apt install --yes git \ 
	python \
	wget \
	python-pip \
	python-numpy \
	python-tk  && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install --upgrade \
        biopython \
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
	statsmodels \
	multiprocessing \
	emission

RUN git clone \
       --branch v0.1.0 \
       https://github.com/philippdre/omniCLIP.git && \
    cd /opt/omniCLIP/stat/ && ./CompileCython.sh

ENV PYTHONPATH=${PYTHONPATH}:/opt/omniCLIP:/opt/omniCLIP/stat:/opt/omniCLIP/data_parsing

VOLUME  /data
WORKDIR /data/
