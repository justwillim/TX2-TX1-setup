# 1. flash the TX2
## download jetpack L4T 3.0
* do not run the script in sudo mode when installing host components
* do not install OpenCV4Tegra V2.4 for TX2, we will use OpenCV3
* for TX2 you may need to flash it tiwce, one just flash the OS, the other install cuda
* if the tx1/tx2 cannot boot the GUI, but shut down after finish loading BIOS, try to change a more powerful power source

## basic tools
`sudo apt-get install terminator -y`

`sudo apt-get install git`

`sudo apt-get install cmake -y`

`sudo apt-get install vim -y`

`sudo apt-get install htop`

# 2. Eigen manuly
## install Eigen stable release V3.3.3
* http://eigen.tuxfamily.org/index.php?title=Main_Page
* it will fail 6 ctest cases out of 798

host:
`scp ~/Downloads/eigen-eigen-67e894c6cd8f.tar.bz2 ubuntu@<YOUR_SSH PATH>:~/`

`cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DEIGEN_TEST_CXX11=ON -DEIGEN_CUDA_COMPUTE_ARCH=53 -DEIGEN_BUILD_BTL=ON`

`make check`

this step will take really a long time

# 3. ceres manly
## normal install, without eigen, need pass all ctest cases
## typical Ceres test bench mark is 131s

# 4. Download buildOpencvTX2, remove libeigen3-dev, install Opencv manuly

# 5. ros-desktop source install, remove eigen & opencv3

# ROSTX2

you could install ROS through apt, but it might conflict with OPENCV3-CUDA

1 if ROS deb init fall try

`sudo c_rehash /etc/ssl/certs`

2 to enable best performence mode use:

`~$ sudo nvpmodel -m 0`

`~$ sudo ./jecson_clock.sh`

# some useful scropts
monitor the CPU temperture

`watch -n 1 cat /sys/devices/virtual/thermal/thermal_zone1/temp`

check CUDA version

`nvcc -V`



