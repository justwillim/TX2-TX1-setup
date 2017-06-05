# 1. flash the TX2
## download jetpack L4T 3.0
* do not run the script in sudo mode, although it will require root permition inside
* do not install OpenCV4Tegra V2.4 for TX2, we will use OpenCV3
* for TX2 you may need to flash it tiwce, one just flash the OS, the other install cuda
* if the tx1/tx2 cannot boot the GUI, but shut down after finish loading BIOS, try to change a more powerful power source

# 2. Eigen manuly
## install Eigen stable release V3.3.3
* http://eigen.tuxfamily.org/index.php?title=Main_Page
* it will fail 6 ctest cases out of 798

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
