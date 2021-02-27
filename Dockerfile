FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install sudo dialog apt-utils && \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get install -y lib32z1 xinetd psmisc python3 && \
    apt-get install -y qemu-user && \
    useradd -u 8888 -m pwn

COPY ./share /home/pwn
COPY ./xinetd /etc/xinetd.d/xinetd

WORKDIR /home/pwn

EXPOSE 8888

CMD ["/usr/sbin/xinetd", "-dontfork"]
