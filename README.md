Provide a docker for the unitree sdk2 python package to directly communicate with a unitree robot. Also (optionally) provides a docker service for unitree's MuJoCo stuff.

All of this is tested on Ubuntu 22.04 LTS and should work on any other reasonable linux distro. Docker Desktop on Windows has not yet been successfully tested, as the network driver causes issues.

## Short installation
`chmod +x install && ./install`

## Usage
- Clone this repo
- Download the official sdk from GitHub: `git clone https://github.com/unitreerobotics/unitree_sdk2_python.git`
    - Or just download and unzip from https://github.com/unitreerobotics/unitree_sdk2_python into this directory if git is not available
    - This is done this way as you are then able to manually change stuff inside the SDK instead of it being directly pulled from GitHub by the docker build process
- Edit the `parent: xxx` part inside `compose.yaml` network part to match the network card name attached via ethernet to the robot (in our case just a LAN adapter)
    - Connection tutorial to follow (TODO)
- Build the image: `docker compose build provider`
- Enable the launch script: `chmod +x start_docker`
- `./start_docker` to start into the bash session with everything installed
- Inside, start python scripts with `python3 [file] eth0`
    - `eth0` and `eth1` are available, `eth0` is connected to the other docker services, `eth1` to the external LAN adapter
        - See `networks` in `compose.yaml`
    - Test connection with the sdk examples

- Coding can be done live inside the mounted `code` directory :)

## MuJoCo
Similar to the main SDK container:
- Download `git clone https://github.com/unitreerobotics/unitree_mujoco.git` into this directory
- Build the image: `docker compose build mujoco`
    - The SDK image must have been built before
- Enable the docker start script: `chmod +x start_mujoco`
- Run the service: `./start_mujoco`

See the original repo for more documentation/details.

When data from the SDK service doesn't seem to reach the simulation, check in both scripts, that the correct domain id and interface are selected. In MuJoCo, this is done in e.g. `simulate_python/config.py`, in the python SDK using the arguments of `ChannelFactoryInitialize(id, interface)`.

### Ollama service
This is a relict from me trying to build a VLA :)