# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/PotatoProject/manifest.git -b dumaloo-release -g default,-device,-mips,-darwin,-notdefault,-pdk,-pdk-fs,-tradefed,-developers,-vts,-tools
git clone https://github.com/ECr34T1v3/android_.repo_local_manifests.git --depth 1 -b beyond0-posp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch potato_beyond0lte-userdebug
export TZ=Asia/Dhaka #put before last build command
brunch beyond0lte

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
