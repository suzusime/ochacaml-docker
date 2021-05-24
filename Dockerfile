FROM ubuntu:16.04

WORKDIR /root
RUN apt update && apt install -y wget patch gcc make
RUN wget http://caml.inria.fr/pub/distrib/caml-light-0.75/cl75unix.tar.gz
RUN wget http://pllab.is.ocha.ac.jp/~asai/OchaCaml/download/OchaCaml140414-utf.tar.gz
RUN tar xf cl75unix.tar.gz
RUN tar xf OchaCaml140414-utf.tar.gz
RUN patch -p0 < OchaCaml/OchaCaml.diff
RUN cd cl75/src && \
    sed -i s/-no-cpp-precomp// Makefile && \
    make configure && \
    make world
RUN echo 'export PATH=/root/OchaCaml:$PATH' >> /root/.bashrc

CMD ["bash"]
