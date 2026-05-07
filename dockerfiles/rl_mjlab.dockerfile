FROM laika/unitree_sdk2_python:latest

# install unitree_rl_mjlab following https://github.com/unitreerobotics/unitree_rl_mjlab/blob/main/doc/setup_en.md
RUN apt update && apt install -y libyaml-cpp-dev libboost-all-dev libeigen3-dev libspdlog-dev libfmt-dev
WORKDIR /app
COPY unitree_rl_mjlab/ ./unitree_rl_mjlab
WORKDIR /app/unitree_rl_mjlab/
RUN pip install -e .

#CMD [ "/bin/ls" ]
CMD [ "/bin/bash"]