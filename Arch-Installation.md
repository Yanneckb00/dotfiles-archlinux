# Arch Linux Setup

Meine persönliche Arch-Linux-Installation und Dotfiles.

## Table of Contents

- [Installation](#installation)
- [Post Installation](#post-installation)
- [Firewall](#firewall)
- [Multilib](#multilib)
- [AUR / yay](#aur--yay)
- [Terminal](#terminal)
- [Dotfiles](#dotfiles)
- [Spicetify](#spicetify)
- [Fonts & Icons](#fonts--icons)
- [GNOME](#gnome)
- [GNOME Extensions](#gnome-extensions)
- [Package Backup](#package-backup)
- [Maintenance](#maintenance)

---

# Installation

## Prepare installation media

Create an Arch Linux installation USB using Ventoy and the latest Arch Linux ISO.

Boot the computer from the USB stick.

## Basic network setup

Set the keyboard layout:

```bash
loadkeys de-latin1
```

Check network interfaces:

```bash
ip addr show
```

### Wi-Fi

Start `iwctl`:

```bash
iwctl
```

Inside `iwctl`:

```text
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect "<network-name>"
```

Exit:

```text
exit
```

Check the connection:

```bash
ip addr show
ping -c 4 archlinux.org
```

---

## SSH into the installation environment

Optional — useful when installing from another computer.

Install OpenSSH:

```bash
pacman -S --needed openssh
```

Start the SSH server:

```bash
systemctl enable --now sshd
```

Set the root password:

```bash
passwd
```

Find the IP address:

```bash
ip addr show
```

Connect from another computer:

```bash
ssh root@<ip>
```

---

# Arch Linux Installation

Start the installer:

```bash
archinstall
```

### Recommended settings

| Option | Value |
|---|---|
| Language | `English` |
| Keyboard layout | `de` |
| Locale | `de_DE.UTF-8` |
| Locale encoding | `UTF-8` |
| Hostname | `archlinux` |
| Root password | Set password |
| User | Create normal user |
| Profile | `GNOME` / `Hyprland` |
| Graphics driver | `AMD / ATI (open source)` |
| Greeter | `gdm` / `ly` |
| Audio | `PipeWire` |
| Kernels | `linux`, `linux-lts` |
| Network | `NetworkManager` |
| Timezone | `Europe/Berlin` |

### Disk configuration

Use:

```text
Best effort
```

I currently use a single root filesystem without a separate `/home` partition.

> **Warning:** Disk configuration is destructive. Verify the selected disk before continuing.

After installation:

```bash
reboot
```

Remove the installation USB when prompted.

---

# Post Installation

First perform a complete system update:

```bash
sudo pacman -Syu
```

## Install basic packages

```bash
sudo pacman -S --needed \
    curl \
    fzf \
    zsh \
    git \
    stow \
    lazygit \
    starship \
    zoxide \
    fastfetch \
    lsd \
    tmux \
    neovim \
    7zip \
    bitwarden \
    firefox \
    ghostty \
    gimp \
    gnome-tweaks \
    obsidian \
    ollama \
    flatpak \
    ffmpeg \
    jq \
    poppler \
    fd \
    ripgrep \
    imagemagick \
    gnome-shell-extensions
```

---

# Firewall

Install UFW:

```bash
sudo pacman -S --needed ufw
```

Set the default policies:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

If SSH should remain accessible:

```bash
sudo ufw allow ssh
```

Enable UFW:

```bash
sudo ufw enable
```

Check the status:

```bash
sudo ufw status verbose
```

If SSH is no longer needed:

```bash
sudo ufw delete allow ssh
```

---

# Multilib

Enable the 32-bit repository if you need Steam, Wine or other 32-bit software.

Edit:

```bash
sudo nano /etc/pacman.conf
```

Uncomment:

```ini
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Then perform a full system upgrade:

```bash
sudo pacman -Syu
```

---

# AUR / yay

Install the required build tools:

```bash
sudo pacman -S --needed git base-devel
```

Clone `yay`:

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

Verify the installation:

```bash
yay --version
```

## Install AUR packages

Install packages that are not available in the official repositories:

```bash
yay -S --needed \
    resvg \
    zen-browser \
    spicetify-cli
```

> **Note:** Review AUR PKGBUILDs before installing software you do not trust. AUR packages are user-maintained build recipes.

---

# Terminal

## Zsh

Set Zsh as the default shell:

```bash
chsh -s /bin/zsh
```

Log out and back in afterwards.

## Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Zinit

```bash
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

> **Note:** Shell installation scripts downloaded with `curl | sh` execute remote code directly. Review scripts before running them if reproducibility/security is important.

---

# Dotfiles

## SSH key

Generate an SSH key:

```bash
ssh-keygen -t ed25519 -C "<email>"
```

Display the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Add the key to your GitHub account.

Clone the repository:

```bash
git clone git@github.com:Yanneckb00/dotfiles-archlinux.git
cd dotfiles-archlinux
```

## GNU Stow

On a fresh system:

```bash
stow .
```

If configuration files already exist and you intentionally want to adopt them:

```bash
stow . --adopt
```

After using `--adopt`, always inspect the changes:

```bash
git status
git diff
```

---

# Spicetify

Install the Spicetify Marketplace:

```bash
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh
```

After a Spotify update, re-apply Spicetify:

```bash
spicetify backup apply
```

If necessary:

```bash
spicetify update
```

If Spotify/Spicetify compatibility is broken:

```bash
spicetify restore backup apply
```

If no compatible Spicetify update exists yet, wait for a new release.

> **Spotify note:** Spotify's Linux package version changes independently of Arch. Avoid hard-coding a Spotify AUR version in this README. If the package fails to build, check the current Spotify package version and AUR PKGBUILD.

---

# Fonts & Icons

## Fonts

### Poppins

[Poppins – Google Fonts](https://fonts.google.com/specimen/Poppins)

### Outfit

[Outfit – Google Fonts](https://fonts.google.com/specimen/Outfit)

### JetBrainsMono Nerd Font

```bash
sudo pacman -S --needed ttf-jetbrains-mono-nerd
```

---

## Icons

### Papirus

```bash
sudo pacman -S --needed papirus-icon-theme
```

[Papirus Icon Theme](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

### La Capitaine

```bash
mkdir -p ~/.icons
git clone https://github.com/keeferrourke/la-capitaine-icon-theme.git ~/.icons/la-capitaine
```

### MoreWaita

```bash
yay -S morewaita-icon-theme
```

[MoreWaita](https://github.com/somepaulo/MoreWaita)

---

# GNOME

Current environment:

- Arch Linux
- GNOME Shell 50.4
- Wayland
- Zsh

## Fractional Scaling

### Wayland

```bash
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
```

### X11

```bash
gsettings set org.gnome.mutter experimental-features "['x11-randr-fractional-scaling']"
```

### Reset

```bash
gsettings reset org.gnome.mutter experimental-features
```

> **Note:** Fractional-scaling behavior is GNOME-version dependent.

---

# GNOME Extensions

Install the browser connector:

```bash
sudo pacman -S --needed gnome-browser-connector
```

This allows the browser integration on [GNOME Extensions](https://extensions.gnome.org/) to communicate with GNOME.

## GNOME Extensions Manager

The repository contains a small helper script:

```text
.config/gnome-extensions/
├── extensions.txt
├── extensions-settings.dconf
└── gnome-extensions-manager
```

Make the script executable:

```bash
chmod +x \
    ~/.config/gnome-extensions/gnome-extensions-manager
```

Create a convenient command:

```bash
mkdir -p ~/.local/bin

ln -sf \
    ~/.config/gnome-extensions/gnome-extensions-manager \
    ~/.local/bin/gnome-extensions-manager
```

If `~/.local/bin` is not in `$PATH`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Export current configuration

On an existing system:

```bash
gnome-extensions-manager export
```

This updates:

```text
extensions.txt
extensions-settings.dconf
```

### Restore after a fresh installation

```bash
gnome-extensions-manager restore
```

This installs compatible extensions, restores their `dconf` configuration and enables the extensions from `extensions.txt`.

### Update extensions

```bash
gnome-extensions-manager update
```

### Check status

```bash
gnome-extensions-manager status
```

### Compare backup with current system

```bash
gnome-extensions-manager diff
```

---

# Package Backup

## Official repository packages

Export explicitly installed packages:

```bash
pacman -Qqe > packages.txt
```

Restore them after a fresh installation:

```bash
sudo pacman -S --needed - < packages.txt
```

> **Note:** Package names can change or packages can disappear from the repositories. Review `packages.txt` before restoring it.

## Foreign / AUR packages

Export packages that are not installed from the official repositories:

```bash
pacman -Qqm > foreign-packages.txt
```

Restore them with:

```bash
yay -S --needed - < foreign-packages.txt
```

> **Note:** `pacman -Qm` lists foreign packages, not exclusively AUR packages. Review the list before restoring it.

---

# Maintenance

## Update the system

Regularly update the official repositories and installed packages:

```bash
sudo pacman -Syu
```

## Update AUR packages

```bash
yay
```

## List explicitly installed packages

```bash
pacman -Qe
```

## List foreign packages

```bash
pacman -Qm
```

## Update GNOME extensions

```bash
gnome-extensions-manager update
```

## Export GNOME configuration after changes

If you changed your GNOME extensions or their settings:

```bash
gnome-extensions-manager export
```

Then commit the changes:

```bash
cd ~/dotfiles-archlinux

git status
git add .
git commit -m "Update GNOME configuration"
git push
```

---

# Repository Structure

```text
dotfiles-archlinux/
│
├── .config/
│   ├── ...
│   └── gnome-extensions/
│       ├── extensions.txt
│       ├── extensions-settings.dconf
│       └── gnome-extensions-manager
│
├── packages.txt
├── foreign-packages.txt
└── README.md
```