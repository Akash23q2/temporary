# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/ShapeShiftOS/android_manifest.git -b android_11 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/SumonSN/Local-Manifests.git --depth 1 -b RMX3171 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch ssos_RMX3171-userdebug
export TZ=Asia/Dhaka #put before last build command
mka derp

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/RMX3171/*UNOFFICIAL*.zip cirrus:RMX3171 -P
