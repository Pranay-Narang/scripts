BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
TOOLCHAIN_DIR=~/toolchain/bin
KERNEL_DIR=~/kernel
KERN_IMG=$KERNEL_DIR/arch/arm64/boot/Image.gz-dtb

export ARCH=arm64
export KBUILD_BUILD_USER="The_DarkBeast"
export KBUILD_BUILD_HOST="Weed-Machine"
STRIP="~/toolchain/bin/aarch64-linux-android-strip"
export CCOMPILE=$CROSS_COMPILE
export CROSS_COMPILE=aarch64-linux-android-
export PATH=$PATH:~/toolchain/bin

cd ~/kernel
echo -e "Making Config"
make oneplus2_defconfig
echo -e "Starting Build"
echo -e "$blue**************************************************************************** $nocal"
echo "                    "
echo "                                   $yellowCompiling DarkBeast Kernel $nocal             "
echo "                    "
echo -e "$blue**************************************************************************** $nocal"
make -j32
if ! [ -a $KERN_IMG ];
then
echo -e "$red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
cd ..
echo -e "Moving shiz"
rm -rf ~/zipper/tools/Image.gz-dtb
rm -rf ~/zipper/DarkBeast*
cp ~/kernel/arch/arm64/boot/Image.gz-dtb ~/zipper/Image.gz-dtb
cd ~/zipper
zip -r DarkBeast-Kernel-v2-oneplus2-$(date +"%Y%m%d").zip *
echo -e "Done"
