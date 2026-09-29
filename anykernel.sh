### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=kernel by @Fukazzz
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=sweet
device.name2=sweetin
supported.versions=11 - 16
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties

### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
} # end attributes

# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

# boot install
dump_boot;

# fix GPU firmware permission denied
if [ -d /vendor/firmware ]; then
  ui_print "- Applying GPU firmware permission bypass...";
  chmod 755 /vendor/firmware;
  [ -f /vendor/firmware/a630_sqe.fw ] && chmod 644 /vendor/firmware/a630_sqe.fw;
  [ -f /vendor/firmware/a615_zap.mdt ] && chmod 644 /vendor/firmware/a615_zap.mdt;
  [ -f /vendor/firmware/awinic/a618_gmu.bin ] && chmod 644 /vendor/firmware/awinic/a618_gmu.bin;
fi

write_boot;
## end boot install
