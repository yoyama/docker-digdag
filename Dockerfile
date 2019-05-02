FROM openjdk:8u191-jre-alpine
LABEL maintainer "youy"

ENV DIGDAG_VERSION 0.9.36
WORKDIR /src

RUN apk add --no-cache \
      bash \
      curl \
      g++ \
      gcc \
      git \
      glib-dev \
      make \
      openssh \
      py-pip \
      python \
      python-dev \
      ruby \
      ruby-bundler \
      ruby-dev \
      ruby-json && \
    pip install --upgrade pip && \
    pip install python-dateutil && \
    mkdir -p /opt/digdag/bin /opt/digdag/logs && \
    curl -o /opt/digdag/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-${DIGDAG_VERSION}" && \
    chmod +x /opt/digdag/bin/digdag && \
    sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bash_profile && \
    echo 'export PS1="[\[\e[1;34m\]\u\[\e[00m\]@\[\e[0;32m\]\h\[\e[00m\] \[\e[1;34m\]\W\[\e[00m\]]$ "' >> ~/.bashrc

ENTRYPOINT ["java", "-jar", "/opt/digdag/bin/digdag"]
