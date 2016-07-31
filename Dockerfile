FROM ubuntu

RUN apt-get update && \
    apt-get install -y make autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
    sed git unzip bash help2man wget bzip2 wget vim libtool-bin && \
    rm -rf /var/lib/apt/lists/*

WORKDIR "/opt"
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git && \
    adduser --disabled-password --gecos "" user && \
    chown -R user:user /opt/esp-open-sdk
    
USER user
WORKDIR "/opt/esp-open-sdk"
RUN make
ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin/:$PATH

CMD ["/bin/bash"]
