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
        insmod /vendor/lib/modules/aw8697.ko
        insmod /vendor/lib/modules/goodix_v1430_mmi.ko
        insmod /vendor/lib/modules/lcd.ko
        insmod /vendor/lib/modules/p938x_charger.ko
        insmod /vendor/lib/modules/qpnp-power-on-mmi.ko
        insmod /vendor/lib/modules/qpnp-smbcharger-mmi.ko
        insmod /vendor/lib/modules/sensors_class.ko
        insmod /vendor/lib/modules/synaptics_core_module.ko
        insmod /vendor/lib/modules/synaptics_device.ko
        insmod /vendor/lib/modules/synaptics_diagnostics.ko
        insmod /vendor/lib/modules/synaptics_i2c.ko
        insmod /vendor/lib/modules/synaptics_recovery.ko
        insmod /vendor/lib/modules/synaptics_reflash.ko
        insmod /vendor/lib/modules/synaptics_testing.ko
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
        cp /v/lib/modules/aw8697.ko /vendor/lib/modules/aw8697.ko
        cp /v/lib/modules/goodix_v1430_mmi.ko /vendor/lib/modules/goodix_v1430_mmi.ko
        cp /v/lib/modules/lcd.ko /vendor/lib/modules/lcd.ko
        cp /v/lib/modules/p938x_charger.ko /vendor/lib/modules/p938x_charger.ko
        cp /v/lib/modules/qpnp-power-on-mmi.ko /vendor/lib/modules/qpnp-power-on-mmi.ko
        cp /v/lib/modules/qpnp-smbcharger-mmi.ko /vendor/lib/modules/qpnp-smbcharger-mmi.ko
        cp /v/lib/modules/sensors_class.ko /vendor/lib/modules/sensors_class.ko
        cp /v/lib/modules/synaptics_core_module.ko /vendor/lib/modules/synaptics_core_module.ko
        cp /v/lib/modules/synaptics_device.ko /vendor/lib/modules/synaptics_device.ko
        cp /v/lib/modules/synaptics_diagnostics.ko /vendor/lib/modules/synaptics_diagnostics.ko
        cp /v/lib/modules/synaptics_i2c.ko /vendor/lib/modules/synaptics_i2c.ko
        cp /v/lib/modules/synaptics_recovery.ko /vendor/lib/modules/synaptics_recovery.ko
        cp /v/lib/modules/synaptics_reflash.ko /vendor/lib/modules/synaptics_reflash.ko
        cp /v/lib/modules/synaptics_testing.ko /vendor/lib/modules/synaptics_testing.ko
        cp /v/lib/modules/touchscreen_mmi.ko /vendor/lib/modules/touchscreen_mmi.ko

        insmod /vendor/lib/modules/aw8697.ko
        insmod /vendor/lib/modules/goodix_v1430_mmi.ko
        insmod /vendor/lib/modules/lcd.ko
        insmod /vendor/lib/modules/p938x_charger.ko
        insmod /vendor/lib/modules/qpnp-power-on-mmi.ko
        insmod /vendor/lib/modules/qpnp-smbcharger-mmi.ko
        insmod /vendor/lib/modules/sensors_class.ko
        insmod /vendor/lib/modules/synaptics_core_module.ko
        insmod /vendor/lib/modules/synaptics_device.ko
        insmod /vendor/lib/modules/synaptics_diagnostics.ko
        insmod /vendor/lib/modules/synaptics_i2c.ko
        insmod /vendor/lib/modules/synaptics_recovery.ko
        insmod /vendor/lib/modules/synaptics_reflash.ko
        insmod /vendor/lib/modules/synaptics_testing.ko
        insmod /vendor/lib/modules/touchscreen_mmi.ko
        umount /v
        rmdir /v
    fi
}

load
wait 1

setprop modules.loaded 1

exit 0
