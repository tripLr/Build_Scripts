#!/bin/bash

# Script to Build and Upload AEX TBLTE

# Set Build Parameters

# Server Specific compile settings


. ~/bin/gdrive_aliases.sh

# Set build directory parameters
export BUILDd=~/android/aex-9.x

# Set roomservice dir and create if necessary
export ROOMd=$BUILDd/.repo/local_manifests

if 
   [ ! -d $ROOMd ];
         then
    mkdir -pv $ROOMd ;
    exit ;
         else
    echo ' roomservice dir exists ' 
fi

# set web location of roomservice for device
export ROOMs=https://raw.githubusercontent.com/triplr-dev/local_manifests/aex-9.x/master.xml

# set target build directories for copying files

export out_dir=$OUT_DIR_COMMON_BASE

# tblte out
export AEXtblte=$out_dir/AEX/target/product/tblte
export kernelTB=$out_dir/AEX/target/product/tblte/obj/KERNEL_OBJ/arch/arm/boot


# pull ~/bin/compile.sh variable for system shared dir
export sharedTB=$shareD/AEX_tblte
if 
   [ ! -d $sharedTB ];
  then
	echo 'Shared Dir does not exist on this system ';
	echo 'run command mkdir -pv $ROOMd ';
        exit ;   
  else
    echo '$sharedTR exists ' ;
fi

# test share section
###

## build rom section

cd $BUILDd

# remove room service files
rm -v $ROOMd/*.xml

# install from web roomservice
wget -O $ROOMd/AEX.xml $ROOMs
REPO

# set environment for build 
. build/envsetup.sh

cd $BUILDd
# build tblte
lunch aosp_tblte-userdebug
mka aex -j$(nproc --all) | tee tblte-log.txt

cd $AEXtblte
ls -al
filename_tblte=$(basename *-tblte*.zip)
cp -v $BUILDd/tblte-log.txt $sharedTB/$filename_tblte.log
mv -v  $filename_tblte*  $sharedTB
mv -v $kernelTB/Image $sharedTB/$filename_tblte.img
cd $sharedTB
ls -al
gdrive upload --parent $AEXtblteG $filename_tblte 
gdrive upload --parent $AEXtblteG $filename_tblte.img 
gdrive upload --parent $AEXtblteG $filename_tblte.md5sum

exit
