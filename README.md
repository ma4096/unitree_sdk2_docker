Provide a docker for the unitree sdk2 python package to directly communicate with a unitree robot.

## Usage
- Clone this repo
- Download the official sdk from GitHub: `git clone https://github.com/unitreerobotics/unitree_sdk2_python.git`
    - Or just download and unzip from https://github.com/unitreerobotics/unitree_sdk2_python into this directory if git is not available
    - This is done this way as you are then able to manually change stuff inside the SDK instead of it being directly pulled from GitHub by the docker build process
- Edit the `parent: xxx` part inside `compose.yaml` network part to match the network card name attached via ethernet to the robot (in our case just a LAN adapter)
    - Connection tutorial to follow (TODO)
- `docker compose run provider` to start into the bash session with everython installed
- Inside, start python scripts with `python3 [file] eth0`
    - `eth0` seems to be the standard name for networks inside docker containers
    - Test connection with the sdk examples

- Coding can be done live inside the mounted `code` directory :)