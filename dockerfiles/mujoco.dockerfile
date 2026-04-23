FROM laika/unitree_sdk2_python:latest

# install unitree_mujoco for a simulation environment
RUN pip3 install mujoco pygame
WORKDIR /app
COPY unitree_mujoco/ ./unitree_mujoco
WORKDIR /app/unitree_mujoco/simulate_python

#CMD [ "/bin/ls" ]
CMD [ "python3", "unitree_mujoco.py"]