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

RUN apt-get install libmono-system-drawing4.0-cil \
	libmono-system-runtime4.0-cil \
	libmono-system-servicemodel4.0a-cil \
	libmono-system-web-services4.0-cil \
	libmono-cil-dev -y

RUN apt-get install gnupg ca-certificates -y
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update
RUN apt-get install mono-devel -y

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
