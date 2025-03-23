# 🛡️ Ubuntu Backup & Restore Tool

A simple and powerful command-line tool to **backup and restore your Ubuntu system to/from a NAS** using `rsync`.  
It features a user-friendly terminal interface with a **progress bar**, **file tracking**, and **time estimation**.

---

## 🚀 Features

- ✅ Full system backup using `rsync -aAX`
- ✅ Optional detailed file-by-file view
- ✅ Real-time **progress bar** with:
  - Files processed / total files
  - Elapsed time
  - Estimated time remaining
- ✅ NAS configuration via `.conf` file
- ✅ DEB package for easy installation
- ✅ Supports restore from NAS

---

## 🧰 Requirements

- Ubuntu (or any Debian-based distro)
- `rsync` (installed by default)
- Network access to a NAS (via SSH or mounted path)

---

## 📦 Installation

### 🟩 Option 1 – Install via `.deb` package (recommended)

```bash
sudo dpkg -i backup-restore-tool_1.0_all.deb
```

This will:

- Install the script to `/usr/local/bin/ubuntu_backup_restore`
- Create a global alias: `backup-tool`
- Install the config file at: `/etc/backup-restore-tool/nas_config.conf`

### 🛠 Initial setup

Edit the config file with your NAS connection details:

```bash
sudo nano /etc/backup-restore-tool/nas_config.conf
```

Example:

```bash
nas_user=yourusername
nas_ip=192.168.1.100
nas_path=/volume1/backups/ubuntu
```

---

## 🧪 Usage

To launch the tool:

```bash
sudo backup-tool
```

You'll be prompted to:
1. Choose between **backup** or **restore**
2. Confirm or edit NAS connection
3. Optionally view advanced per-file logs
4. Watch your progress in real-time ⏱️

---

## 🗑️ Uninstallation

To uninstall the tool:

```bash
sudo apt remove backup-restore-tool
```

Or with `dpkg`:

```bash
sudo dpkg -r backup-restore-tool
```

To also remove the config file:

```bash
sudo rm -rf /etc/backup-restore-tool
```

---

## 📁 Files installed by the package

| File/Path                                              | Description                         |
|--------------------------------------------------------|-------------------------------------|
| `/usr/local/bin/ubuntu_backup_restore`                 | The main executable script          |
| `/usr/local/bin/backup-tool`                           | Global alias for convenience        |
| `/etc/backup-restore-tool/nas_config.conf`             | NAS configuration file              |
| `/usr/share/applications/backup-restore.desktop`       | Desktop entry (optional)            |

---

## 💡 Notes

- The script does **not backup temporary or system-specific folders** like `/proc`, `/dev`, `/sys`, etc.
- All data is transferred via `rsync`, which is efficient and incremental.
- For safety, always **test restore on a secondary machine or VM** before applying it to production.

---

## 📄 License

MIT License – do whatever you want, just don’t blame me if your NAS blows up 🔥

---

## 🧑‍💻 Author

Created with ❤️ by [Théo Avril](https://github.com/theox33)  
Contributions welcome!