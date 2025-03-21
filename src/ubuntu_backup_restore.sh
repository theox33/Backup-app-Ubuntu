#!/bin/bash

CONFIG_FILE="./nas_config.conf"

# -------------------------
# Création du fichier de config si absent
# -------------------------
if [ ! -f "$CONFIG_FILE" ]; then
  echo "🔧 Configuration NAS introuvable. Créons-la maintenant."

  read -p "Nom d'utilisateur NAS : " nas_user
  read -p "Adresse IP du NAS (ex : 192.168.1.195) : " nas_ip
  read -p "Chemin de sauvegarde sur le NAS (ex : /volume1/NetBackup/backupdata_ubuntu_full) : " nas_path

  echo "nas_user=\"$nas_user\"" > "$CONFIG_FILE"
  echo "nas_ip=\"$nas_ip\"" >> "$CONFIG_FILE"
  echo "nas_path=\"$nas_path\"" >> "$CONFIG_FILE"

  echo "✅ Configuration sauvegardée dans $CONFIG_FILE"
fi

# -------------------------
# Chargement des variables de config
# -------------------------
source "$CONFIG_FILE"

# -------------------------
# Menu principal
# -------------------------
echo "=============================="
echo " OUTIL DE SAUVEGARDE & RESTAURATION UBUNTU"
echo "=============================="
echo "Configuration NAS actuelle :"
echo "  Utilisateur : $nas_user"
echo "  Adresse IP : $nas_ip"
echo "  Chemin     : $nas_path"
echo
echo "Que voulez-vous faire ?"
echo "1) Sauvegarder (sauvegarde du système actuel)"
echo "2) Restaurer (restauration du système dans /mnt)"
read -p "Votre choix [1 ou 2] : " choice

if [ "$choice" == "1" ]; then
  echo "→ Démarrage de la sauvegarde complète vers le NAS..."
  sudo rsync -aAXv / \
    --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
    "$nas_user@$nas_ip:$nas_path" \
    --progress --stats

  echo "✅ Sauvegarde terminée avec succès !"

elif [ "$choice" == "2" ]; then
  echo "→ Restauration du système à partir du NAS vers /mnt..."
  echo "⚠️  Assurez-vous d'avoir monté la partition de destination dans /mnt"
  read -p "Voulez-vous continuer ? [o/N] : " confirm
  if [[ "$confirm" =~ ^[OoYy]$ ]]; then
    sudo rsync -aAXv "$nas_user@$nas_ip:$nas_path/" /mnt \
      --progress --stats

    echo "✅ Restauration terminée avec succès !"
    echo "➡️  Vous devez maintenant entrer dans le système avec chroot et réinstaller GRUB :"
    echo "   sudo mount --bind /dev /mnt/dev"
    echo "   sudo mount --bind /proc /mnt/proc"
    echo "   sudo mount --bind /sys /mnt/sys"
    echo "   sudo chroot /mnt"
    echo "   grub-install /dev/sdX"
    echo "   update-grub"
    echo "   exit && sudo umount -R /mnt && reboot"
  else
    echo "❌ Restauration annulée."
  fi

else
  echo "❌ Choix invalide."
fi
