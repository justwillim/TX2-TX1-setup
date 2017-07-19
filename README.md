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

in opencv V3.2.0
opencv_test_cudev will fail, but acturally, it success, ctest made a wrong test compare between 2.0 and 2.

TX1 result:
```
Label Time Summary:
Accuracy                 = 2187.12 sec (27 tests)
Main                     = 6063.93 sec (71 tests)
Performance              = 3202.87 sec (22 tests)
Sanity                   = 673.94 sec (22 tests)
opencv_calib3d           = 303.71 sec (3 tests)
opencv_core              = 1201.93 sec (3 tests)
opencv_cudaarithm        = 203.99 sec (3 tests)
opencv_cudabgsegm        =  10.81 sec (3 tests)
opencv_cudacodec         =   0.45 sec (3 tests)
opencv_cudafeatures2d    =  24.15 sec (3 tests)
opencv_cudafilters       = 137.54 sec (3 tests)
opencv_cudaimgproc       = 371.67 sec (3 tests)
opencv_cudalegacy        = 137.41 sec (3 tests)
opencv_cudaobjdetect     =  11.42 sec (3 tests)
opencv_cudaoptflow       =  28.72 sec (3 tests)
opencv_cudastereo        =  25.07 sec (3 tests)
opencv_cudawarping       = 605.62 sec (3 tests)
opencv_cudev             =   1.99 sec (1 test)
opencv_features2d        = 125.05 sec (3 tests)
opencv_flann             =   0.02 sec (1 test)
opencv_highgui           =   0.05 sec (1 test)
opencv_imgcodecs         =  75.52 sec (3 tests)
opencv_imgproc           = 761.49 sec (3 tests)
opencv_ml                =  84.47 sec (1 test)
opencv_objdetect         =  22.82 sec (3 tests)
opencv_photo             = 236.25 sec (3 tests)
opencv_shape             = 1089.02 sec (1 test)
opencv_stitching         = 328.15 sec (3 tests)
opencv_superres          =  30.62 sec (3 tests)
opencv_video             = 124.65 sec (3 tests)
opencv_videoio           = 121.32 sec (3 tests)

Total Test time (real) = 6064.09 sec

The following tests FAILED:
	  1 - opencv_test_cudev (Failed)
	 17 - opencv_perf_cudabgsegm (Failed)
	 23 - opencv_perf_cudaimgproc (Failed)
	 26 - opencv_perf_cudawarping (Failed)
	 27 - opencv_sanity_cudawarping (Failed)
	 35 - opencv_test_videoio (Failed)
	 41 - opencv_test_highgui (Failed)
	 54 - opencv_test_cudalegacy (Failed)
	 55 - opencv_perf_cudalegacy (Failed)
	 67 - opencv_perf_stitching (Failed)
	 68 - opencv_sanity_stitching (Failed)
```
# 5. ros-desktop source install, remove eigen & opencv3

# ROSTX2

you could install ROS through apt, but it might conflict with OPENCV3-CUDA

1 if ROS deb init fall try

`sudo c_rehash /etc/ssl/certs`

2 to enable best performence mode use:

`~$ sudo nvpmodel -m 0`

`~$ sudo ./jecson_clock.sh`

## SDL
`sudo apt-get install libsdl-image1.2-dev 

and

sudo apt-get install libsdl-dev

# some useful scropts
monitor the CPU temperture

`watch -n 1 cat /sys/devices/virtual/thermal/thermal_zone1/temp`

check CUDA version

`nvcc -V`


# Enable /dev/ttyTHS2 (UART1) for TX2

## install dtc 
```
sudo apt-get install device-tree-compiler
```
## rewrite kernel

### enable tty THS2
```
sudo -s
cd /tmp
dtc -I dtb -O dts -o extracted.dts /boot/tegra186-quill-p3310-1000-c03-00-base.dtb
# Search for "serial@c280000" where it is a block of code and not just a single line...
# Change status = "disabled" to status = "okay";
# Build a modified version:
dtc -I dts -O dtb -o /boot/modified_tegra186-quill-p3310-1000-c03-00-base.dtb extracted.dts
cd /boot/extlinux
# edit extlinux.conf...add this line between MENU LABEL line and LINUX line:
FDT /boot/modified_tegra186-quill-p3310-1000-c03-00-base.dtb
```
### enable CAN buss

ref: http://www.jetsonhacks.com/2017/03/25/build-kernel-and-modules-nvidia-jetson-tx2/

```
$ git clone https://github.com/jetsonhacks/buildJetsonTX2Kernel.git
```

### use Manifold2 board USBs

todo write notes


# test Ethernet speeed

```
$ sudo apt-get install iperf
#start server
$ sudo iperf -s
#start client
$ sudo iperf -c 192.168.1.xxx -i 5
```

# install SSH keys
```
ssh-copy-id user@123.45.56.78
```

# bash tools

## devlist
devlist is 
```
aliased to `sudo arp-scan --interface=eth0 192.168.1.0/24 | grep NVIDIA'
```

## dev 
devlist is aliased to `sudo arp-scan --interface=eth0 192.168.1.0/24 | grep NVIDIA'
dev is a function
```
dev () 
{ 
    local ip="$(sudo arp-scan --interface=eth0 192.168.1.0/24 | grep NVIDIA | sed -n $1p | cut -d'	' -f 1)";
    echo "ssh into $ip";
    ssh nvidia@$ip
}
````
