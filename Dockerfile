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
RUN yum install -y pigz
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda
ENV PATH="~/miniconda/bin:${PATH}"

# Install SAMTOOLS
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 -O ~/samtools-1.9.tar.bz2
RUN cd ~ && tar xfv ~/samtools-1.9.tar.bz2
RUN cd ~/samtools-1.9 && ./configure --prefix=/usr/local && make && make install

# Install STAR
RUN wget https://github.com/alexdobin/STAR/archive/2.6.1d.tar.gz -O ~/2.6.1d.tar.gz
RUN cd ~ && tar -xzf ~/2.6.1d.tar.gz
RUN cp ~/STAR-2.6.1d/bin/Linux_x86_64/* /usr/local/bin

# Install SKEWER
RUN wget http://downloads.sourceforge.net/project/skewer/Binaries/skewer-0.2.2-linux-x86_64 -O /usr/local/bin/skewer
RUN chmod +x /usr/local/bin/skewer

# Cleanup
RUN rm -fr ~/*tar*
RUN rm -fr ~/miniconda.sh
RUN rm -fr ~/samtools-1.9/
RUN rm -fr ~/STAR-2.6.1d/
