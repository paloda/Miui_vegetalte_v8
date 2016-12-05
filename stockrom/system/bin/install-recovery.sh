#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 10582016 94246ec08f79b0755554e6aba674961ae96ebfab 8220672 03550a186fb48ec57119513078064bf8e5cb154b
fi

if ! applypatch -c EMMC:/dev/block/bootdevice/by-name/recovery:10582016:94246ec08f79b0755554e6aba674961ae96ebfab; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/bootdevice/by-name/boot:8220672:03550a186fb48ec57119513078064bf8e5cb154b EMMC:/dev/block/bootdevice/by-name/recovery 94246ec08f79b0755554e6aba674961ae96ebfab 10582016 03550a186fb48ec57119513078064bf8e5cb154b:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
