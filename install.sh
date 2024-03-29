##########################################################################################
#
# Magisk Module Installer Script
#
##########################################################################################
##########################################################################################
#
# Instructions:
#
# 1. Place your files into system folder (delete the placeholder file)
# 2. Fill in your module's info into module.prop
# 3. Configure and implement callbacks in this file
# 4. If you need boot scripts, add them into common/post-fs-data.sh or common/service.sh
# 5. Add your additional or modified system properties into common/system.prop
#
##########################################################################################

##########################################################################################
# Config Flags
##########################################################################################

# Set to true if you do *NOT* want Magisk to mount
# any files for you. Most modules would NOT want
# to set this flag to true
SKIPMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=false

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=false

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info about how Magic Mount works, and why you need this

###########################################################################
# Make sure the Path is correct
REPLACE="
/system/vendor/etc/mixer_paths.xml
"

##########################################################################################
#
# Function Callbacks
#
# The following functions will be called by the installation framework.
# You do not have the ability to modify update-binary, the only way you can customize
# installation is through implementing these functions.
#
# When running your callbacks, the installation framework will make sure the Magisk
# internal busybox path is *PREPENDED* to PATH, so all common commands shall exist.
# Also, it will make sure /data, /system, and /vendor is properly mounted.
#
##########################################################################################
##########################################################################################
#
# The installation framework will export some variables and functions.
# You should use these variables and functions for installation.
#
# ! DO NOT use any Magisk internal paths as those are NOT public API.
# ! DO NOT use other functions in util_functions.sh as they are NOT public API.
# ! Non public APIs are not guranteed to maintain compatibility between releases.
#
# Available variables:
#
# MAGISK_VER (string): the version string of current installed Magisk
# MAGISK_VER_CODE (int): the version code of current installed Magisk
# BOOTMODE (bool): true if the module is currently installing in Magisk Manager
# MODPATH (path): the path where your module files should be installed
# TMPDIR (path): a place where you can temporarily store files
# ZIPFILE (path): your module's installation zip
# ARCH (string): the architecture of the device. Value is either arm, arm64, x86, or x64
# IS64BIT (bool): true if $ARCH is either arm64 or x64
# API (int): the API level (Android version) of the device
#
# Availible functions:
#
# ui_print <msg>
#     print <msg> to console
#     Avoid using 'echo' as it will not display in custom recovery's console
#
# abort <msg>
#     print error message <msg> to console and terminate installation
#     Avoid using 'exit' as it will skip the termination cleanup steps
#
# set_perm <target> <owner> <group> <permission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     this function is a shorthand for the following commands
#       chown owner.group target
#       chmod permission target
#       chcon context target
#
# set_perm_recursive <directory> <owner> <group> <dirpermission> <filepermission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     for all files in <directory>, it will call:
#       set_perm file owner group filepermission context
#     for all directories in <directory> (including itself), it will call:
#       set_perm dir owner group dirpermission context
#
##########################################################################################
##########################################################################################
# If you need boot scripts, DO NOT use general boot scripts (post-fs-data.d/service.d)
# ONLY use module scripts as it respects the module status (remove/disable) and is
# guaranteed to maintain the same behavior in future Magisk releases.
# Enable boot scripts by setting the flags in the config section above.
##########################################################################################

##########################################################################################
# Installation Message
##########################################################################################

# Set what you want to show when installing your mod

print_modname() {
  ui_print "+----------------------------------------+"
  ui_print "+          -<DualSpeaker Mod>-           +"
  ui_print "+    Asus Zenfone Max Pro M1 (X00TD)     +"
  ui_print "+    Asus Zenfone Max Pro M2 (X01BD)     +"
  ui_print "+________________________________________+"
  ui_print "+         By lscambo13 & Dante63         +"
  ui_print "+------------- Version: 2.x -------------+"
  ui_print "+-------------- 04/06/2019 --------------+"
}

# Copy/extract your module files into $MODPATH in on_install.

on_install() {
  # The following is the default implementation: extract $ZIPFILE/system to $MODPATH
  # Extend/change the logic to whatever you want
if [[ $(getprop ro.product.device) == X01BD ]]; then
  ui_print "Supported device found (X01BD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
elif [[ $(getprop ro.product.device) == ASUS_X01BD ]]; then
  ui_print "Supported device found (X01BD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
elif [[ $(getprop ro.product.device) == X01BDA ]]; then
  ui_print "Supported device found (X01BD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
elif [[ $(getprop ro.product.device) == ASUS_X01BD_2 ]]; then
  ui_print "Supported device found (X01BD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
elif [[ $(getprop ro.product.device) == ASUS_X01BDA ]]; then
  ui_print "Supported device found (X01BD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
if [[ $(getprop ro.product.device) == X00TD ]]; then
  ui_print "Supported device found (X00TD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
elif [[ $(getprop ro.product.device) == ASUS_X00TD ]]; then
  ui_print "Supported device found (X00TD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
if [[ $(getprop ro.product.device) == X00T ]]; then
  ui_print "Supported device found (X00TD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
elif [[ $(getprop ro.product.device) == ASUS_X00T ]]; then
  ui_print "Supported device found (X00TD). Installing..."
	unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
else
	cancel "Unsupported Device!"
  fi
}

# Only some special files require specific permissions
# This function will be called after on_install is done
# The default permissions should be good enough for most cases

set_permissions() {
  # The following is the default rule, DO NOT remove
  set_perm_recursive $MODPATH 0 0 0755 0644

  # Make sure the Path is correct
  # set_perm  $MODPATH/
  # then you place the path
  # set_perm  $MODPATH/system/etc/mixer_paths.xml
  # the permissions are --- rw- r-- r-- which is 0644
  set_perm  $MODPATH/system/vendor/etc/mixer_paths.xml       0       0       0644
  ui_print "+----------------------------------------+"
  ui_print "+          R E B O O T  N O W !          +"
  ui_print "+----------------------------------------+"
}

# You can add more functions to assist your custom script code
cancel() {
  imageless_magisk || unmount_magisk_image
  abort "$1"
}
