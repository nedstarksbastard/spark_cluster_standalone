FROM openjdk:8-alpine

USER root

# wget, tar, bash for getting spark and hadoop
RUN apk --update add wget tar bash

# Get tars of spark and hadoop
RUN wget http://apache.mirror.anlx.net/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz

# Install spark
RUN tar -xzf spark-2.4.5-bin-hadoop2.7.tgz && \
    mv spark-2.4.5-bin-hadoop2.7 /spark && \
    rm spark-2.4.5-bin-hadoop2.7.tgz

# add to PATH
ENV PATH $PATH:/spark/bin:/spark/sbin

ENV SPARK_HOME /spark

# Copy scripts for running spark master and slave
COPY scripts/run_master.sh /run_master.sh
COPY scripts/run_worker.sh /run_worker.sh
COPY job_server.py /job_server.py
COPY templates /templates

# Install components for Python
RUN apk add --no-cache --update \
    git \
    libffi-dev \
    openssl-dev \
    zlib-dev \
    bzip2-dev \
    readline-dev \
    sqlite-dev \
    musl \
    libc6-compat \
    linux-headers \
    build-base \
    procps \
    ca-certificates


# Set Python version
ARG PYTHON_VERSION='3.7.6'
# Set pyenv home
ARG PYENV_HOME=/root/.pyenv

# Install pyenv, then install python version
RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_HOME && \
    rm -rfv $PYENV_HOME/.git

ENV PATH $PYENV_HOME/shims:$PYENV_HOME/bin:$PATH

RUN pyenv install $PYTHON_VERSION
RUN pyenv global $PYTHON_VERSION
RUN pip install --upgrade pip && pyenv rehash
RUN pip install flask pyspark
#RUN pip install pyspark numpy pandas

# Clean
RUN rm -rf ~/.cache/pip

RUN chmod +x /run_master.sh
RUN chmod +x /run_worker.sh
