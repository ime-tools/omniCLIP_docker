FROM ubuntu:latest
MAINTAINER Daniel Amsel "daniel.amsel@ime.fraunhofer.de"

RUN apt update && apt install --yes git python wget python-pip python-numpy
RUN cd /data/
RUN git clone https://github.com/philippdre/omniCLIP.git
RUN pip install --upgrade pip
RUN pip install biopython brewer2mpl cython gffutils h5py intervaltree matplotlib pandas prettyplotlib pysam scikit-learn scipy statsmodels
RUN cd /omniCLIP/stat/
RUN ./CompileCython.sh
RUN cd /data
