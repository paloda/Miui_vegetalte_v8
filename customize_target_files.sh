#/bin/bash
PWD=`pwd`
METADATA_DIR=$PWD/metadata
OUT_DIR=$PWD/out
TARGET_FILES_DIR=$OUT_DIR/target_files
build_prop_file=$TARGET_FILES_DIR/SYSTEM/build.prop
OTHER_DIR=$PWD/other

cp -f other/file_contexts out/target_files/META/
rm -rf out/target_files/SYSTEM/vendor/preinstall

#Added device features
cp -f other/merlin.xml out/target_files/SYSTEM/etc/device_features

cp -f metadata/updater out/target_files/OTA/bin/

cp -f stockrom/boot.img out/target_files/BOOTABLE_IMAGES/

#Added multi cust variants for miui
rm -rf out/target_files/DATA/miui/cust
cp -rf other/cust out/target_files/DATA/miui
