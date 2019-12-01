#!/bin/bash
# AEX			repo init --depth=1 -u git://github.com/AospExtended/manifest.git -b 9.x
# AICP			repo init --depth=1 -u https://github.com/AICP/platform_manifest.git -b p9.0
# AOKP			repo init --depth=1 -u https://github.com/AOKP/platform_manifest.git -b pie
# AOSiP 		repo init -u git://github.com/AOSiP/platform_manifest.git -b pie
# LineageOS		repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-16.0
# Pixel Expierence	repo init --depth=1 -u https://github.com/PixelExperience/manifest -b pie
# ViperOS		repo init --depth=1 -u https://github.com/ViperOS/viper_manifest.git -b pie
# xenon 		repo init --depth=1 -u https://github.com/TeamHorizon/platform_manifest.git -b p

export BUILDd=~/android/9/AOSiP
export INITd=$BUILDd/.repo
export ROOMd=$BUILDd/.repo/local_manifests
export manifest='repo init -u git://github.com/AOSiP/platform_manifest.git -b pie'
#

# check to see if $BUILDd exists, if not then create
if [ ! -d $BUILDd ] 	;
	then
		mkdir -pv $BUILDd 	;
	else
		echo '$BUILDd exists'
fi


# check to see if repo exists, if not create , init repo, and sync repo
if 
   [ ! -d $INITd ]	;
	then
		cd $BUILDd ;
		repo init --depth=1 -u $manifest 	;
		repo sync -c -j12 --force-sync --no-clone-bundle --no-tags	;
		echo "REPO init and sync complete"		
     	else
    		echo '$INITd exists ' 
fi

# check to see if room servce directory exists , if not create 
if 
   [ ! -d $ROOMd ]	;
      then
    	mkdir -pv $ROOMd 	;
	cd $BUILDd 	;
         else
    echo '$ROOMd dir exists ' 
fi

# change dir to build dir , to prepare to build 
cd $BUILDd
pwd

