FROM amazonlinux:latest

# Install dependencies
RUN sudo yum groupinstall -y "Development Tools"
RUN sudo yum install -y ncurses-devel
RUN sudo yum install -y bzip2-devel
RUN sudo yum install -y xz-devel
RUN sudo yum install -y libcurl
RUN sudo yum install -y libcurl-devel
RUN sudo yum install -y openssl-devel
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda
RUN export PATH="$HOME/miniconda/bin:$PATH"
RUN pip install --user awscli-cwlogs
RUN pip install --user aegea

# Install HTSeq
RUN pip install --user numpy
RUN pip install --user HTseq

# Install SAMTOOLS
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
RUN tar xfv samtools-1.9.tar.bz2
RUN mkdir programs
RUN cd samtools-1.9
RUN ./configure --prefix=/home/ec2-user/programs
RUN make
RUN make install
RUN export PATH=/home/ec2-user/programs/bin:$PATH

# Install STAR
RUN cd ~
RUN wget https://github.com/alexdobin/STAR/archive/2.7.0e.tar.gz
RUN tar -xzf 2.7.0e.tar.gz
RUN cp STAR-2.7.0e/bin/Linux_x86_64/* programs/bin/

# Cleanup
RUN rm -fr *tar*
RUN rm -fr miniconda.sh
RUN rm -fr samtools-1.9/
RUN rm -fr STAR-2.7.0e/
