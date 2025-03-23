# 🛡️ Outil de Sauvegarde & Restauration Ubuntu

Un outil simple et puissant en ligne de commande pour **sauvegarder et restaurer votre système Ubuntu vers/depuis un NAS** en utilisant `rsync`.  
Il propose une interface conviviale dans le terminal avec une **barre de progression**, un **suivi des fichiers**, et une **estimation du temps**.

---

## 🚀 Fonctionnalités

- ✅ Sauvegarde complète du système avec `rsync -aAX`
- ✅ Vue détaillée optionnelle fichier par fichier
- ✅ **Barre de progression** en temps réel avec :
  - Fichiers traités / total des fichiers
  - Temps écoulé
  - Temps restant estimé
- ✅ Configuration NAS via un fichier `.conf`
- ✅ Paquet DEB pour une installation facile
- ✅ Supporte la restauration depuis un NAS

---

## 🧰 Prérequis

- Ubuntu (ou toute distribution basée sur Debian)
- `rsync` (installé par défaut)
- Accès réseau à un NAS (via SSH ou chemin monté)

---

## 📦 Installation

### 🟩 Option 1 – Installer via le paquet `.deb` (recommandé)

```bash
sudo dpkg -i backup-restore-tool_1.0_all.deb
```

Cela va :

- Installer le script dans `/usr/local/bin/ubuntu_backup_restore`
- Créer un alias global : `backup-tool`
- Installer le fichier de configuration à : `/etc/backup-restore-tool/nas_config.conf`

### 🛠 Configuration initiale

Modifiez le fichier de configuration avec les détails de connexion à votre NAS :

```bash
sudo nano /etc/backup-restore-tool/nas_config.conf
```

Exemple :

```bash
nas_user=yourusername
nas_ip=192.168.1.100
nas_path=/volume1/backups/ubuntu
```

---

## 🧪 Utilisation

Pour lancer l'outil :

```bash
sudo backup-tool
```

Vous serez invité à :
1. Choisir entre **sauvegarde** ou **restauration**
2. Confirmer ou modifier la connexion au NAS
3. Afficher ou non les journaux avancés par fichier
4. Suivre votre progression en temps réel ⏱️

---

## 🗑️ Désinstallation

Pour désinstaller l'outil :

```bash
sudo apt remove backup-restore-tool
```

Ou avec `dpkg` :

```bash
sudo dpkg -r backup-restore-tool
```

Pour également supprimer le fichier de configuration :

```bash
sudo rm -rf /etc/backup-restore-tool
```

---

## 📁 Fichiers installés par le paquet

| Fichier/Chemin                                         | Description                         |
|--------------------------------------------------------|-------------------------------------|
| `/usr/local/bin/ubuntu_backup_restore`                 | Le script principal exécutable      |
| `/usr/local/bin/backup-tool`                           | Alias global pour plus de commodité |
| `/etc/backup-restore-tool/nas_config.conf`             | Fichier de configuration NAS        |
| `/usr/share/applications/backup-restore.desktop`       | Entrée de bureau (optionnelle)      |

---

## 💡 Notes

- Le script **ne sauvegarde pas les dossiers temporaires ou spécifiques au système** comme `/proc`, `/dev`, `/sys`, etc.
- Toutes les données sont transférées via `rsync`, qui est efficace et incrémental.
- Par sécurité, testez toujours la **restauration sur une machine secondaire ou une VM** avant de l'appliquer en production.

---

## 📄 Licence

Licence MIT – faites ce que vous voulez, mais ne me blâmez pas si votre NAS explose 🔥

---

## 🧑‍💻 Auteur

Créé avec ❤️ par [Théo Avril](https://github.com/theox33)  
Contributions bienvenues !