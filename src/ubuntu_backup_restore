#!/bin/bash

CONFIG_FILE="./nas_config.conf"

# -------------------------
# Create config file if missing
# -------------------------
if [ ! -f "$CONFIG_FILE" ]; then
  echo "🔧 NAS config not found. Let's set it up."

  read -p "Enter NAS username: " nas_user
  read -p "Enter NAS IP address (e.g. 192.168.1.195): " nas_ip
  read -p "Enter NAS path (e.g. /volume1/NetBackup/backupdata_ubuntu_full): " nas_path

  echo "nas_user=\"$nas_user\"" > "$CONFIG_FILE"
  echo "nas_ip=\"$nas_ip\"" >> "$CONFIG_FILE"
  echo "nas_path=\"$nas_path\"" >> "$CONFIG_FILE"

  echo "✅ Config saved to $CONFIG_FILE"
fi

# -------------------------
# Load config variables
# -------------------------
source "$CONFIG_FILE"

# -------------------------
# Menu
# -------------------------
echo "=============================="
echo " UBUNTU BACKUP & RESTORE TOOL"
echo "=============================="
echo "Current NAS Config:"
echo "  NAS User : $nas_user"
echo "  NAS IP   : $nas_ip"
echo "  NAS Path : $nas_path"
echo
echo "What do you want to do?"
echo "1) Backup (Save current system)"
echo "2) Restore (Recover system to /mnt)"
read -p "Enter choice [1 or 2]: " choice

if [ "$choice" == "1" ]; then
  echo "→ Starting full system backup to NAS..."
  sudo rsync -aAXv / \
    --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
    "$nas_user@$nas_ip:$nas_path" \
    --progress --stats

  echo "✅ Backup completed!"

elif [ "$choice" == "2" ]; then
  echo "→ Restoring system from NAS to /mnt..."
  echo "⚠️  Make sure you've already mounted the destination partition at /mnt"
  read -p "Continue? [y/N]: " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    sudo rsync -aAXv "$nas_user@$nas_ip:$nas_path/" /mnt \
      --progress --stats

    echo "✅ Restore completed!"
    echo "➡️  You should now chroot into /mnt and reinstall GRUB:"
    echo "   sudo mount --bind /dev /mnt/dev"
    echo "   sudo mount --bind /proc /mnt/proc"
    echo "   sudo mount --bind /sys /mnt/sys"
    echo "   sudo chroot /mnt"
    echo "   grub-install /dev/sdX"
    echo "   update-grub"
    echo "   exit && sudo umount -R /mnt && reboot"
  else
    echo "❌ Restore cancelled."
  fi

else
  echo "❌ Invalid choice."
fi
