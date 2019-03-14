# Set the base image
FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /opt/conda/bin:$PATH

# File Author / Maintainer
MAINTAINER ktrav@stanford.edu

# Add packages, update image, and clear cache
RUN apt-get update
RUN apt-get install -y apt-utils 
RUN apt-get install -y build-essential wget zip unzip bzip2 git zlib1g-dev pkg-config make libbz2-dev python-pip libncurses-dev liblzma-dev pigz

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda config --set always_yes yes --set changeps1 no
RUN conda update -q conda
RUN conda config --add channels defaults
RUN conda config --add channels conda-forge
RUN conda config --add channels bioconda
RUN conda install -n root _license

RUN conda create --name utilities-env python=3.6 pip
RUN conda install samtools
RUN conda install awscli-cwlogs
RUN pip install aegea

# Install STAR
RUN wget --quiet https://github.com/alexdobin/STAR/archive/2.6.1d.tar.gz -O ~/2.6.1d.tar.gz
RUN cd ~ && tar -xzf ~/2.6.1d.tar.gz
RUN cp ~/STAR-2.6.1d/bin/Linux_x86_64/* /usr/local/bin

# Install SKEWER
RUN wget --quiet http://downloads.sourceforge.net/project/skewer/Binaries/skewer-0.2.2-linux-x86_64 -O /usr/local/bin/skewer
RUN chmod +x /usr/local/bin/skewer

# Cleanup
RUN rm -fr ~/*tar*
RUN rm -fr ~/STAR-2.6.1d/
