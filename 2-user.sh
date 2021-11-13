#!/usr/bin/env bash
#-------------------------------------------------------------------------
#_   _            _      _   _                               _     _ _
#| | | | __ _  ___| | __ | |_| |__   ___  __      _____  _ __| | __| | |
#| |_| |/ _` |/ __| |/ / | __| '_ \ / _ \ \ \ /\ / / _ \| '__| |/ _` | |
#|  _  | (_| | (__|   <  | |_| | | |  __/  \ V  V / (_) | |  | | (_| |_|
#|_| |_|\__,_|\___|_|\_\  \__|_| |_|\___|   \_/\_/ \___/|_|  |_|\__,_(_)
#-------------------------------------------------------------------------

echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

echo "CLONING: YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ~
sudo cp -r BtwIUseArch/.zhsrc $HOME

PKGS=(
'autojump'
'awesome-terminal-fonts'
'brave-bin' # Brave Browser
'deadd-notification-center'
'dxvk-bin' # DXVK DirectX to Vulcan
'gitkraken'
'lightly-git'
'lightlyshaders-git'
'mangohud' # Gaming FPS Counter
'mangohud-common'
'nerd-fonts-fira-code'
'nordic-darker-standard-buttons-theme'
'nordic-darker-theme'
'nordic-kde-git'
'nordic-theme'
'noto-fonts-emoji'
'papirus-icon-theme'
'plasma-pa'
'volnoti-brightness-git'
'ocs-url' # install packages from websites
'sddm-nordic-theme-git'
'snapper-gui-git'
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-roboto'
'zoom' # video conferences
'snap-pac'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

export PATH=$PATH:~/.local/bin
cp -r $HOME/BtwIUseArch/dotfiles/* $HOME/.config/
pip install konsave
konsave -i $HOME/ArchTitus/kde.knsv
sleep 1
konsave -a kde

echo -e "\nInstallign BlackArch Stuff\n"
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
sudo pacman -Syu
sudo pacman -S --noconfirm blackarch 
sudo pacman -Syyu --needed blackarch --overwrite='*'

echo -e "\nDone!\n"
exit
