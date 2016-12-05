#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/FaceLock/FaceLock.apk
app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleTTS/GoogleTTS.apk
etc/default-permissions/opengapps-permissions.xml
etc/g.prop
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/sysconfig/google.xml
etc/sysconfig/google_build.xml
etc/sysconfig/google_vr_build.xml
etc/sysconfig/nexus.xml
etc/sysconfig/whitelist_com.android.omadm.service.xml
framework/com.google.android.dialer.support.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libfacelock_jni.so
lib/libfilterpack_facedetect.so
lib/libjni_keyboarddecoder.so
lib/libjni_latinimegoogle.so
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleFeedback/GoogleFeedback.apk
priv-app/GoogleLoginService/GoogleLoginService.apk
priv-app/GoogleOneTimeInitializer/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/HotwordEnrollment/HotwordEnrollment.apk
priv-app/Phonesky/Phonesky.apk
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/SetupWizard/SetupWizard.apk
priv-app/Velvet/Velvet.apk
usr/srec/en-US/APP_NAME.fst
usr/srec/en-US/APP_NAME.syms
usr/srec/en-US/CLG.prewalk.fst
usr/srec/en-US/CONTACT_NAME.fst
usr/srec/en-US/CONTACT_NAME.syms
usr/srec/en-US/SONG_NAME.fst
usr/srec/en-US/SONG_NAME.syms
usr/srec/en-US/c_fst
usr/srec/en-US/class_normalizer.mfar
usr/srec/en-US/commands.abnf
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/config.pumpkin
usr/srec/en-US/confirmation_bias.fst
usr/srec/en-US/contacts.abnf
usr/srec/en-US/contacts_bias.fst
usr/srec/en-US/contacts_disambig.fst
usr/srec/en-US/dict
usr/srec/en-US/dictation.config
usr/srec/en-US/dnn
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/endpointer_model
usr/srec/en-US/endpointer_model.mmap
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/ep_portable_mean_stddev
usr/srec/en-US/ep_portable_model.mmap
usr/srec/en-US/g2p.data
usr/srec/en-US/g2p_fst
usr/srec/en-US/grammar.config
usr/srec/en-US/graphemes.syms
usr/srec/en-US/hmm_symbols
usr/srec/en-US/hmmlist
usr/srec/en-US/input_mean_std_dev
usr/srec/en-US/lexicon.U.fst
usr/srec/en-US/lstm_model.uint8.data
usr/srec/en-US/magic_mic.config
usr/srec/en-US/metadata
usr/srec/en-US/monastery_config.pumpkin
usr/srec/en-US/norm_fst
usr/srec/en-US/normalizer.mfar
usr/srec/en-US/offensive_word_normalizer.mfar
usr/srec/en-US/offline_action_data.pb
usr/srec/en-US/phonelist
usr/srec/en-US/phonelist.syms
usr/srec/en-US/phonemes.syms
usr/srec/en-US/portable_lstm
usr/srec/en-US/portable_meanstddev
usr/srec/en-US/pumpkin.mmap
usr/srec/en-US/rescoring.fst.louds
usr/srec/en-US/semantics.pumpkin
usr/srec/en-US/voice_actions.config
usr/srec/en-US/voice_actions_compiler.config
usr/srec/en-US/word_classifier
usr/srec/en-US/wordlist.syms
vendor/lib/libfrsdk.so
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/landmark_group_meta_data.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/left_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-tree7-wmd.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/nose_base-y0-yi45-p0-pi45-r0-ri20.lg_32-tree7-wmd.bin
vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/right_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-3-tree7-wmd.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-r0-ri30.4a-v24-tree7-2-wmd.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-rn30-ri30.5-v24-tree7-2-wmd.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-rp30-ri30.5-v24-tree7-2-wmd.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/pose-r.8.1.bin
vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/pose-y-r.8.1.bin
vendor/pittpatt/models/recognition/face.face.y0-y0-71-N-tree_7-wmd.bin
EOF
}

# Backup/Restore using /sdcard if the installed GApps size plus a buffer for other addon.d backups (204800=200MB) is larger than /tmp
installed_gapps_size_kb=$(grep "^installed_gapps_size_kb" /tmp/gapps.prop | cut -d= -f2)
if [ ! "$installed_gapps_size_kb" ]; then
  installed_gapps_size_kb=$(cd /system; du -ak $(list_files) | awk '{ i+=$1 } END { print i }')
  echo "installed_gapps_size_kb=$installed_gapps_size_kb" >> /tmp/gapps.prop
fi

free_tmp_size_kb=$(grep "^free_tmp_size_kb" /tmp/gapps.prop | cut -d= -f2)
if [ ! "$free_tmp_size_kb" ]; then
  free_tmp_size_kb=$(df -k /tmp | tail -n 1 | awk '{ print $4 }')
  echo "free_tmp_size_kb=$free_tmp_size_kb" >> /tmp/gapps.prop
fi

buffer_size_kb=204800
if [ $((installed_gapps_size_kb + buffer_size_kb)) -ge "$free_tmp_size_kb" ]; then
  C=/sdcard/tmp-gapps
fi

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file "$S"/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file "$S"/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Remove Stock/AOSP apps (from GApps Installer)
    rm -rf /system/priv-app/ExtServices
    rm -rf /system/app/Provision
    rm -rf /system/priv-app/Provision

    # Remove 'other' apps (per installer.data)
    rm -rf /system/app/CalendarGoogle
    rm -rf /system/app/CloudPrint
    rm -rf /system/app/DeskClockGoogle
    rm -rf /system/app/EditorsDocsStub
    rm -rf /system/app/EditorsSheetsStub
    rm -rf /system/app/EditorsSlidesStub
    rm -rf /system/app/Gmail
    rm -rf /system/app/Gmail2
    rm -rf /system/app/GoogleCalendar
    rm -rf /system/app/GoogleCloudPrint
    rm -rf /system/app/GoogleHangouts
    rm -rf /system/app/GoogleKeep
    rm -rf /system/app/GoogleLatinIme
    rm -rf /system/app/GooglePlus
    rm -rf /system/app/Keep
    rm -rf /system/app/NewsWeather
    rm -rf /system/app/NewsstandStub
    rm -rf /system/app/PartnerBookmarksProvider
    rm -rf /system/app/PrebuiltBugleStub
    rm -rf /system/app/PrebuiltKeepStub
    rm -rf /system/app/QuickSearchBox
    rm -rf /system/app/Vending
    rm -rf /system/priv-app/GmsCore
    rm -rf /system/priv-app/GmsCore_update
    rm -rf /system/priv-app/GoogleHangouts
    rm -rf /system/priv-app/GoogleNow
    rm -rf /system/priv-app/GoogleSearch
    rm -rf /system/priv-app/OneTimeInitializer
    rm -rf /system/priv-app/QuickSearchBox
    rm -rf /system/priv-app/Velvet_update
    rm -rf /system/priv-app/Vending

    # Remove 'priv-app' apps from 'app' (per installer.data)
    rm -rf /system/app/CanvasPackageInstaller
    rm -rf /system/app/ConfigUpdater
    rm -rf /system/app/GoogleBackupTransport
    rm -rf /system/app/GoogleFeedback
    rm -rf /system/app/GoogleLoginService
    rm -rf /system/app/GoogleOneTimeInitializer
    rm -rf /system/app/GooglePartnerSetup
    rm -rf /system/app/GoogleServicesFramework
    rm -rf /system/app/OneTimeInitializer
    rm -rf /system/app/Phonesky
    rm -rf /system/app/PrebuiltGmsCore
    rm -rf /system/app/SetupWizard
    rm -rf /system/app/Velvet

    # Remove 'required' apps (per installer.data)
    rm -rf /system/app/LatinIME/lib//libjni_keyboarddecoder.so
    rm -rf /system/app/LatinIME/lib//libjni_latinimegoogle.so
    rm -rf /system/lib/libjni_keyboarddecoder.so
    rm -rf /system/lib/libjni_latinimegoogle.so
    rm -rf /system/lib64/libjni_keyboarddecoder.so
    rm -rf /system/lib64/libjni_latinimegoogle.so

    # Remove 'user requested' apps (from gapps-config)

  ;;
  post-restore)
    # Recreate required symlinks (from GApps Installer)
    install -d "/system/app/FaceLock/lib/arm"
    ln -sfn "/system/lib/libfacelock_jni.so" "/system/app/FaceLock/lib/arm/libfacelock_jni.so"
    install -d "/system/app/LatinIME/lib/arm"
    ln -sfn "/system/lib/libjni_latinimegoogle.so" "/system/app/LatinIME/lib/arm/libjni_latinimegoogle.so"
    ln -sfn "/system/lib/libjni_keyboarddecoder.so" "/system/app/LatinIME/lib/arm/libjni_keyboarddecoder.so"

    # Re-pre-ODEX APKs (from GApps Installer)

    # Remove any empty folders we may have created during the removal process
    for i in /system/app /system/priv-app /system/vendor/pittpatt /system/usr/srec; do
        find $i -type d | xargs -r rmdir -p --ignore-fail-on-non-empty;
    done;
    # Fix ownership/permissions and clean up after backup and restore from /sdcard
    find /system/vendor/pittpatt -type d -exec chown 0:2000 '{}' \; # Change pittpatt folders to root:shell per Google Factory Settings
    for i in $(list_files); do
      chown root:root "/system/$i"
      chmod 644 "/system/$i"
      chmod 755 $(dirname "/system/$i")
    done
    rm -rf /sdcard/tmp-gapps
  ;;
esac
