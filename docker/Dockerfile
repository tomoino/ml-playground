FROM python:3.9-slim-buster

ENV WORK_PATH /workspace

RUN apt-get update && \
    apt-get install -y \
			build-essential && \
    apt-get clean && \
		rm -rf /var/lib/apt/lists/* && \
		rm -rf /var/cache/apk/

COPY requirements.txt $WORK_PATH/docker/
ENV PIP_OPTIONS "--no-cache-dir --progress-bar off"
RUN pip install -U pip && \
    pip install ${PIP_OPTIONS} -r $WORK_PATH/docker/requirements.txt