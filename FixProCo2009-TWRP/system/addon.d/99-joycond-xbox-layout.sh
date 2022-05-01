#!/sbin/sh

. /tmp/backuptool.functions

list_files() {
cat <<EOF
/system/addon.d/99-joycond-xbox-layout.sh
/vendor/usr/keylayout/Vendor_057e_Product_2009.kl
/vendor/usr/keylayout/Vendor_057e_Product_2009_Version_8001.kl
END
EOF
}

case "$1" in
backup)
  mount -t ext4 /dev/block/vendor /vendor -o rw,discard

  list_files | while read FILE; do
    backup_file "$FILE"
  done

  umount /vendor
;;
restore)
  mount -t ext4 /dev/block/vendor /vendor -o rw,discard

  list_files | while read FILE; do
    R=""
    [ -n "$REPLACEMENT" ] && R="$REPLACEMENT"
    [ -f "$C/$FILE" ] && restore_file "$FILE" "$R"
  done

  umount /vendor
;;
pre-backup)
# Stub
;;
post-backup)
# Stub
;;
pre-restore)
# Stub
;;
post-restore)
# Stub
;;
esac
