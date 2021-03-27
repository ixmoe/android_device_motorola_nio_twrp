#!/system/bin/sh

# touch_class_path=/sys/class/touchscreen
# touch_path=
# firmware_path=/vendor/firmware
# firmware_file=
# device=$(getprop ro.boot.device)

# Load Device-Specific Modules (Based on Device Variant)
load()
{
    is_fastboot_twrp=$(getprop ro.boot.fastboot)
    if [ ! -z "$is_fastboot_twrp" ]; then
        insmod /vendor/lib/modules/aw8695.ko
        insmod /vendor/lib/modules/nova_0flash_mmi.ko
        insmod /vendor/lib/modules/touchscreen_mmi.ko
    else
        mkdir /v
        suffix=$(getprop ro.boot.slot_suffix)
        if [ -z "$suffix" ]; then
            suf=$(getprop ro.boot.slot)
            suffix="_$suf"
        fi
        venpath="/dev/block/mapper/vendor$suffix"
        mount -t ext4 -o ro "$venpath" /v
        mkdir -p /vendor/lib/modules
        cp /v/lib/modules/aw8695.ko /vendor/lib/modules/aw8695.ko
        cp /v/lib/modules/nova_0flash_mmi.ko /vendor/lib/modules/nova_0flash_mmi.ko
        cp /v/lib/modules/touchscreen_mmi.ko /vendor/lib/modules/touchscreen_mmi.ko

        insmod /vendor/lib/modules/aw8695.ko
        insmod /vendor/lib/modules/nova_0flash_mmi.ko
        insmod /vendor/lib/modules/touchscreen_mmi.ko
        umount /v
        rmdir /v
    fi
}

load
wait 1

cat /proc/nvt_update

setprop modules.loaded 1

exit 0
