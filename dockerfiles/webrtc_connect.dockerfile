FROM ubuntu:22.04

RUN apt-get update && apt-get install -y python3-pip portaudio19-dev ffmpeg libsm6 libxext6
RUN pip3 install --upgrade pip

WORKDIR /app
COPY unitree_webrtc_connect/ ./unitree_webrtc_connect/

WORKDIR /app/unitree_webrtc_connect
RUN pip install -e .

CMD [ "/bin/bash" ]