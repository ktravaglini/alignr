FROM amazonlinux:latest

# Install dependencies
RUN yum groupinstall -y "Development Tools"
RUN yum install -y ncurses-devel
RUN yum install -y bzip2-devel
RUN yum install -y xz-devel
RUN yum install -y libcurl-devel
RUN yum install -y openssl-devel
RUN yum install -y wget
RUN yum install -y tar
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda
ENV PATH="~/miniconda/bin:${PATH}"
RUN pip install aegea

# Install HTSeq
RUN pip install numpy
RUN pip install HTseq

# Install SAMTOOLS
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 -O ~/samtools-1.9.tar.bz2
RUN cd ~ && tar xfv ~/samtools-1.9.tar.bz2
RUN mkdir ~/programs
RUN cd ~/samtools-1.9 && ./configure --prefix=~/programs && make && make install
RUN export PATH=~/programs/bin:$PATH

# Install STAR
RUN wget https://github.com/alexdobin/STAR/archive/2.7.0e.tar.gz -O ~/2.7.0e.tar.gz
RUN cd ~ && tar -xzf ~/2.7.0e.tar.gz
RUN cp ~/STAR-2.7.0e/bin/Linux_x86_64/* ~/programs/bin/

# Cleanup
RUN rm -fr ~/*tar*
RUN rm -fr ~/miniconda.sh
RUN rm -fr ~/samtools-1.9/
RUN rm -fr ~/STAR-2.7.0e/
