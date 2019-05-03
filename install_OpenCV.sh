######################################
# INSTALL OPENCV ON UBUNTU OR DEBIAN #
######################################

# |          THIS SCRIPT IS TESTED CORRECTLY ON          |
# |------------------------------------------------------|
# | OS               | OpenCV       | Test | Last test   |
# |------------------|--------------|------|-------------|
# | Ubuntu 18.04 LTS | OpenCV 4.1.0 | OK   | 30 Apr 2019 |
# |----------------------------------------------------- |

# VERSION TO BE INSTALLED

OPENCV_VERSION='4.1.0'

# 1. KEEP UBUNTU OR DEBIAN UP TO DATE

sudo apt-get -y update &&
# sudo apt-get -y upgrade       # Uncomment this line to install the newest versions of all packages currently installed
# sudo apt-get -y dist-upgrade  # Uncomment this line to, in addition to 'upgrade', handles changing dependencies with new versions of packages
# sudo apt-get -y autoremove    # Uncomment this line to remove packages that are now no longer needed


# 2. INSTALL THE DEPENDENCIES

# Build tools:
sudo apt-get install -y build-essential cmake &&

# Utils tools:
sudo apt-get install -y unzip pkg-config wget &&

# GUI
sudo apt-get install -y libgtk-3-dev qt5-default &&

# Media I/O:
sudo apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libopenexr-dev libgdal-dev &&

# Video I/O:
sudo apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev &&

# Video
sudo apt install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev ffmpeg &&

# Parallelism and linear algebra libraries:
sudo apt-get install -y libtbb-dev libeigen3-dev &&

# Mathematical optimizations
sudo apt-get install -y libatlas-base-dev gfortran &&

# Python:
sudo apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy &&

# Java:
sudo apt-get install -y ant default-jdk &&

# Documentation:
sudo apt-get install -y doxygen &&


# 3. INSTALL THE LIBRARY

cd /tmp

wget -O opencv.zip https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip &&
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip &&

unzip opencv.zip &&
unzip opencv_contrib.zip &&

# rm -rf opencv.zip &&
# rm -rf opencv_contrib.zip &&

mv opencv-${OPENCV_VERSION} opencv &&
mv opencv_contrib-${OPENCV_VERSION} opencv_contrib &&

cd opencv &&
mkdir build &&
cd build &&

cmake 	-D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D BUILD_opencv_python3=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D INSTALL_C_EXAMPLES=ON \
	-D OPENCV_ENABLE_NONFREE=ON \
  	-D WITH_QT=ON \
  	-D WITH_OPENGL=ON \
  	-D WITH_CUDA=ON \
	-D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
  	-D WITH_OPENCL=ON \
  	-D WITH_EIGEN=ON  \
  	-D WITH_VTK=OFF  \
  	-D WITH_V4L=ON \
  	-D WITH_TBB=ON \
  	-D WITH_IPP=ON \
  	-D WITH_GSTREAMER=ON \
  	-D WITH_FFMPEG=ON \
  	-D BUILD_TESTS=ON \
  	-D BUILD_TIFF=ON \
  	-D BUILD_PERF_TESTS=ON \
  	-D BUILD_opencv_cudacodec=OFF \
 	-D PYTHON3_EXECUTABLE=$(which python) \
 	-D PYTHON3_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
 	-D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
	-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON .. &&

make -j$(nproc) &&
# or, if build is failing when using several cores:
# make &&

sudo make install &&
sudo ldconfig
