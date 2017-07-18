#!/bin/bash

# Declaring colours
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
green='\033[0;32m'
nocol='\033[0m'

# Variables for build
TOOLCHAIN_DIR=~/toolchain/bin
KERNEL_DIR=~/kernel
OUT=~/out
KERN_IMG=$OUT/arch/arm64/boot/Image.gz-dtb

# Var declaration
bool=N

# DarkBeast kernel details
KERNEL_NAME="DarkBeast-Kernel"
DEVICE="garlic"
DATE="$(date +"%Y%m%d")"

# Usefull components for build
export ARCH=arm64
export KBUILD_BUILD_USER="The_DarkBeast"
export KBUILD_BUILD_HOST="Weed-Machine"
STRIP="~/toolchain/bin/aarch64-linux-gnu-"
export CCOMPILE=$CROSS_COMPILE
export CROSS_COMPILE=aarch64-linux-gnu-
export PATH=$PATH:~/toolchain/bin
DATE_START=$(date +"%s")

cd ~/kernel
echo -e "Making Config"
make lineageos_garlic_defconfig O=$OUT
echo -e "Starting Build"
echo -e "$blue**************************************************************************** $nocol"
echo "                    "
echo "                                   Compiling DarkBeast Kernel             "
echo "                    "
echo -e "$blue**************************************************************************** $nocol"
make -j32 O=$OUT

if ! [ -a $KERN_IMG ];
then
    FAIL_END=$(date +"%s")
    FAIL_TIME=$(($FAIL_END - $DATE_START))
    echo -e " "
    echo -e "$red #### make failed to build some targets $(($FAIL_TIME / 60))minutes and $(($FAIL_TIME % 60))seconds #### $nocol"
    exit 1
fi
   DATE_END=$(date +"%s")
   DIFF=$(($DATE_END - $DATE_START))
   echo -e " "
   echo -e "$green#### make completed successfully $(($DIFF / 60))minutes and $(($DIFF % 60))seconds #### $nocol"
   echo " "
   cd ..

echo -e " "
echo -e "Do you want to build the zip y/N"
read bool

if [ $bool = N ]
then
    exit 0

else
    echo -e "What do you want to export as release version"
    read VER
    FINAL_ZIP="$KERNEL_NAME-$VER-$DEVICE-$DATE"
    echo -e "Moving required components to zipper"
    rm -rf ~/zipper/tools/Image.gz-dtb
    rm -rf ~/zipper/DarkBeast*
    cp $OUT/arch/arm64/boot/Image.gz-dtb ~/zipper/Image.gz-dtb
    cd ~/zipper
    echo -e " "
    echo -e "$yellow Zipping all Contents $nocol"
    zip -r $FINAL_ZIP.zip *
    echo -e " "
    echo -e "Zipped all the contents"
    echo -e "Zip Name: $cyan $FINAL_ZIP.zip $nocol"
    echo -e " "
    echo -e "Do you want to upload the zip y/N"
    read bool

    if [ $bool = y ]
    then
        wput ftp://${AFH_CREDENTIALS}@uploads.androidfilehost.com/ ${FINAL_VER}.zip
        echo -e " "
        echo -e "$FINAL_ZIP has been uploaded to your AndroidFileHost account"
    fi
fi
