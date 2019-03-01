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
RUN export PATH="$HOME/miniconda/bin:$PATH"

CMD ['/bin/bash']
