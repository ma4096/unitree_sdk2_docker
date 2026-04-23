FROM ubuntu:22.04

# Manually build and install CycloneDDS C library
WORKDIR /opt

# dependencies of opencv
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
# main dependencies of the unitree sdk2 python
RUN apt-get install -y git cmake python3.11 python3-pip iproute2

RUN git clone --branch 0.10.2 https://github.com/eclipse-cyclonedds/cyclonedds.git \
	&& cd cyclonedds \
	&& mkdir build && cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
	&& make -j$(nproc) \
	&& make install

# Set environment variable so CMake can locate the installed CycloneDDS
ENV CMAKE_PREFIX_PATH=/usr/local
#:$CMAKE_PREFIX_PATH

# install https://github.com/unitreerobotics/unitree_sdk2_python

# python dependencies
RUN pip3 install numpy opencv-python
WORKDIR /app
COPY unitree_sdk2_python/ ./unitree_sdk2_python/
#RUN git clone https://github.com/unitreerobotics/unitree_sdk2_python.git
#WORKDIR /app/unitree_sdk2_python
RUN pip3 install -e ./unitree_sdk2_python/

# install unitree_mujoco for a simulation environment
#RUN pip3 install mujoco pygame
#WORKDIR /app
#COPY unitree_mujoco/ ./unitree_mujoco
#RUN pip3 install -e ./unitree_mujoco/

CMD [ "/bin/bash" ]