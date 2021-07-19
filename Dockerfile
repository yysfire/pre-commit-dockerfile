FROM python:2.7.18-slim-buster

LABEL maintainer="yysfire <https://github.com/yysfire>"

RUN apt-get update && apt-get install -y \
    patch \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt

RUN pip install pre-commit==1.21.0 -i https://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

WORKDIR /project

COPY pre-commit.patch /project/pre-commit.patch

RUN cd /usr/local/lib/python2.7/site-packages/pre_commit && patch -i /project/pre-commit.patch -p0 && rm -f /project/pre-commit.patch

COPY .pre-commit-config_python2.yaml /project/.pre-commit-config.yaml

RUN git init && pre-commit install --install-hooks && \
    rm -rf /project/.pre-commit-config.yaml /project/.git
