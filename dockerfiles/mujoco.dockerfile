FROM laika/unitree_sdk2_python:latest

#RUN apt update && apt install -y curl
#RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# update pip from 22.0.2 to 26.1.1 (as of May 2026) to mitigate a bug when later on locally building mujoco_lidar
RUN pip install --upgrade pip
# install unitree_mujoco for a simulation environment
RUN pip3 install mujoco pygame uv
# mujoco_lidar
# mujoco_lidar is the cpu build, see https://github.com/discoverse-dev/MuJoCo-LiDAR/blob/main/docs/en/INSTALLATION.md for GPU acceleration
WORKDIR /app
COPY unitree_mujoco/ ./unitree_mujoco
COPY MuJoCo-LiDAR/ ./MuJoCo-LiDAR

WORKDIR /app/MuJoCo-LiDAR
RUN pip install -e .
#RUN uv sync --extra dev --extra examples
# this should normally be done by the optional dev packages?
#RUN uv add onnxruntime

WORKDIR /app/unitree_mujoco/simulate_python

CMD [ "/bin/bash" ]
#CMD [ "python3", "unitree_mujoco.py"]