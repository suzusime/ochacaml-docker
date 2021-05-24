FROM ubuntu:20.04

WORKDIR /root
RUN apt update && apt install -y wget patch gcc make
RUN wget http://caml.inria.fr/pub/distrib/caml-light-0.75/cl75unix.tar.gz
RUN wget http://pllab.is.ocha.ac.jp/~asai/OchaCaml/download/OchaCaml140414-utf.tar.gz
RUN tar xf cl75unix.tar.gz
RUN tar xf OchaCaml140414-utf.tar.gz
RUN patch -p0 < OchaCaml/OchaCaml.diff
RUN cd cl75/src && \
    sed -i 's/-D__FAVOR_BSD -no-cpp-precomp/-DHAS_STRERROR/' Makefile && \
    make configure && \
    make world

ENV PATH /root/OchaCaml:$PATH

CMD ["ochacaml"]
