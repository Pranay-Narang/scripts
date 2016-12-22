BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
TOOLCHAIN_DIR=/home/pranaynarang/toolchain/bin
KERNEL_DIR=/home/pranaynarang/kernel
DTBTOOL=/home/pranaynarang/dtbToolCM
KERN_IMG=$KERNEL_DIR/arch/arm64/boot/Image
DT_IMG=$KERNEL_DIR/arch/arm64/boot/dt.img

export ARCH=arm64
export KBUILD_BUILD_USER="The_DarkBeast"
export KBUILD_BUILD_HOST="Weed-Machine"
STRIP="/home/pranaynarang/toolchain/bin/aarch64-linux-android-strip"
export CCOMPILE=$CROSS_COMPILE
export CROSS_COMPILE=aarch64-linux-android-
export PATH=$PATH:/home/pranaynarang/toolchain/bin

cd kernel
echo -e "Making Config"
make cyanogenmod_lettuce-64_defconfig
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
echo -e "Generating dt.img"
$DTBTOOL -2 -o $KERNEL_DIR/arch/arm64/boot/dt.img -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dt$
cd ..
echo -e "Moving shiz"
rm -rf zipper/tools/zImage zipper/tools/dt.img
rm -rf zipper/DarkBeast*
cp kernel/arch/arm64/boot/Image zipper/tools/zImage
cp kernel/arch/arm64/boot/dt.img zipper/tools/dt.img
cd zipper
zip -r DarkBeast-Kernel-v1-lettuce-$(date +"%Y%m%d").zip *
echo -e "Done"
