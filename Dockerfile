FROM python:3.9.5-slim-buster

LABEL maintainer="yysfire <https://github.com/yysfire>"

RUN apt-get update && apt-get install -y \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt

RUN pip install pre-commit -i https://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

WORKDIR /project

COPY .pre-commit-config_python3.yaml /project/.pre-commit-config.yaml

RUN git init && pre-commit install --install-hooks && \
    rm -rf /project/.pre-commit-config.yaml /project/.git
