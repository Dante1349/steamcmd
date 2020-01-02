FROM debian:buster-slim

LABEL maintainer="marcrominger@gmx.de"

ENV STEAMDIR /home/steam/Steam

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget \
        ca-certificates \
        lib32stdc++6 \ 
        lib32gcc1


RUN useradd -m steam
RUN su steam -c \
		"mkdir -p ${STEAMDIR}"
RUN su steam -c \
		"cd ${STEAMDIR} \
		&& wget 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz'"
RUN su steam -c \
		"cd ${STEAMDIR} \
		&& ls \
		&& tar zxvf steamcmd_linux.tar.gz"

USER steam

WORKDIR $STEAMDIR

VOLUME $STEAMDIR
