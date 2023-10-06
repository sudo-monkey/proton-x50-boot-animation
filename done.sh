#!/system/bin/sh

# Log filename setup
logfilename="outputBootReplace_"
timestamp="$(date +%s)"
logfilename="$logfilename$timestamp"
exec > /mnt/media_rw/udisk1/$logfilename.txt 2>&1
export PATH=/sbin:/system/sbin:/system/xbin:/system/bin

# Indicate start of script using wireless charging settings
echo "====== show wireless charging to indicates script start ======="
am start -n com.ecarx.gkuiconfig/.setting.SettingActivity 2>/dev/null
sleep 0.5
input tap 700 200
am start -a android.settings.WPC_SETTINGS 2>/dev/null 

# Mount /system partition as Read-Write
mount -o remount,rw /system

# Remove any leftover bootanimation_backup.mp4 from the system directory
echo "Removing any leftover bootanimation_backup.mp4 from system..."
rm -f /system/media/bootanimation_backup.mp4

# Backup the existing boot animation
echo "Backing up the existing boot animation..."
cp /system/media/bootanimation.mp4 /mnt/media_rw/udisk1/bootanimation_backup.mp4

# Copy the new boot animation from USB to /system/media
echo "Copying the new boot animation from USB..."
cp /mnt/media_rw/udisk1/bootanimation.mp4 /system/media/bootanimation.mp4

# Set correct permissions for the new boot animation
echo "Setting permissions for the new boot animation..."
chmod 644 /system/media/bootanimation.mp4

# Rename the script folder to indicate it has run
echo "====== renaming the script folder ======="
mv /mnt/media_rw/udisk1/b832bc61472727635baffcf25dd28e9f239273e2 /mnt/media_rw/udisk1/b832bc61472727635baffcf25dd28e9f239273e2_done

# Indicate end of script operations
echo "=========== ending the script ============"
am start -a android.settings.SETTINGS    # Show settings app to indicate script completion

# Sync file system changes
sync

