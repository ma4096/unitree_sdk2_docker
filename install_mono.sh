# This installation script does not build the docker containers but rather installs all the software (unitree_sdk2_python, isem_go2_interface, unitree_mujoco) locally.
# This is sometimes useful when you are working in a VM anyway.

echo "Installing unitree_sdk2_python..."
if [ ! -d "./unitree_sdk2_python" ]; then
  git clone https://github.com/unitreerobotics/unitree_sdk2_python.git
fi
if [ ! -d "./isem_go2_interface" ]; then
  git clone https://github.com/ma4096/isem_go2_interface.git
fi

mkdir -p install && cd install

sudo apt-get update && apt-get install ffmpeg libsm6 libxext6 -y
sudo apt-get install -y git cmake python3.11 python3-pip iproute2

git clone --branch 0.10.2 https://github.com/eclipse-cyclonedds/cyclonedds.git \
	&& cd cyclonedds \
	&& mkdir build && cd build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
	&& make -j$(nproc) \
	&& make install

CMAKE_PREFIX_PATH=/usr/local

pip install --upgrade pip
pip install numpy opencv-python uv onnxruntime
cd ../..
pip install -e ./unitree_sdk2_python
pip install -e ./isem_go2_interface


echo "Building the MuJoCo container..."
if [ ! -d "./unitree_mujoco" ]; then
  git clone https://github.com/ma4096/unitree_mujoco.git
fi

pip install mujoco pygame
cd install
git clone https://github.com/discoverse-dev/MuJoCo-LiDAR.git
pip install -e ./MuJoCo-LiDAR

cd ..

echo "Installed unitree_sdk2_python, isem_go2_interface, cyclonedds, unitree_mujoco :)"
