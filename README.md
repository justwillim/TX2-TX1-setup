# 1. flash the TX2
## download jetpack L4T 3.0
## do not install OpenCV4Tegra V2.4 for TX2, we will use OpenCV3

# 2. Eigen manuly
## install Eigen stable release V3.3.3
## will fail 6 ctest cases out of 798

# 3. ceres manly
## normal install, need pass all ctest cases
## typical Ceres test bench mark is 131s

# 4. Download buildOpencvTX2, remove libeigen3-dev, install Opencv manuly

# 5. ros-desktop source install, remove eigen & opencv3

# ROSTX2

1 if ROS deb init fall try

'sudo c_rehash /etc/ssl/certs'

2 to enable best performence mode use:

'sudo nvpmodel -m 0'
