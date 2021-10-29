

FROM ubuntu

LABEL maintainer=BeatriceTeguia
LABEL version=v0.0.1

WORKDIR /mc_scripts
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone \
    && apt-get -y update \
    && apt-get install -y nmap \
    && apt-get install -y tree \
    && apt-get install -y unzip \
    && apt-get install -y --no-install-recommends git \
    && apt-get install -y tcpdump \
    && apt-get install -y iputils-ping \
    && apt-get install -y openssh-server \
    && apt-get install -y net-tools \
    && apt-get install -y curl \
    && apt-get install -y vim \
    && apt-get install -y apt-transport-https ca-certificates curl \
    && curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install -y kubectl
#RUN git clone git@github.com:beatriceteguia/mc_scripts.git
#COPY /* ./
#RUN chmod -R +x *.*
#RUN cd && mkdir .kube && cd .kube 
#&& echo "config" > config
#COPY config /root/.kube
EXPOSE 80
CMD /bin/bash; sleep infinity;
