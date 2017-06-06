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
* or if you build BTL, fail 13 ctest cases out of 832

host:

`scp ~/Downloads/eigen-eigen-67e894c6cd8f.tar.bz2 ubuntu@<YOUR_SSH PATH>:~/`

TX1:
`cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local -DEIGEN_TEST_CXX11=ON -DEIGEN_CUDA_COMPUTE_ARCH=53 -DEIGEN_BUILD_BTL=ON`

TX2:
`cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local -DEIGEN_TEST_CXX11=ON -DEIGEN_CUDA_COMPUTE_ARCH=62 -DEIGEN_BUILD_BTL=ON`

`make check`

TX1 result:

<code>
Label Time Summary:
Official       = 618.29 sec (660 tests)
Unsupported    = 294.54 sec (164 tests)

Total Test time (real) = 963.72 sec

The following tests FAILED:
	384 - qr_colpivoting_3 (OTHER_FAULT)
	479 - bdcsvd_9 (OTHER_FAULT)
	661 - failtests (Failed)
	662 - NonLinearOptimization (OTHER_FAULT)
	684 - matrix_function_1 (OTHER_FAULT)
	714 - sparse_extra_3 (OTHER_FAULT)
	826 - btl_eigen3_linear (Not Run)
	827 - btl_eigen3_vecmat (Not Run)
	828 - btl_eigen3_matmat (Not Run)
	829 - btl_eigen3_adv (Not Run)
	830 - btl_tensor_linear (Not Run)
	831 - btl_tensor_vecmat (Not Run)
	832 - btl_tensor_matmat (Not Run)
<code/>

this step will take really a long time

# 3. ceres manly
normal install, without eigen, need pass all ctest cases

typical Ceres test bench mark is 131s for TX2

ceres-solver.org/ceres-solver-1.12.0.tar.gz

`sudo apt-get install libgoogle-glog-dev`

`sudo apt-get install libatlas-base-dev -y`

`sudo apt-get install libsuitesparse-dev -y`

`tar zxf ceres-solver-1.12.0.tar.gz`

`mkdir ceres-bin`

`cd ceres-bin`

`cmake ../ceres-solver-1.12.0 -DCMAKE_INSTALL_PREFIX=/usr/local` 

`make -j4`

`make test`

TX1 test result:L
100% tests passed, 0 tests failed out of 68

Total Test time (real) = 392.52 sec


`make install`

# 4. Download buildOpencvTX2, remove libeigen3-dev, install Opencv manuly

https://github.com/jetsonhacks/buildOpenCVTX2/blob/master/buildOpenCV.sh

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



