#!/usr/bin/env bash
#-------------------------------------------------------------------------
#_   _            _      _   _                               _     _ _
#| | | | __ _  ___| | __ | |_| |__   ___  __      _____  _ __| | __| | |
#| |_| |/ _` |/ __| |/ / | __| '_ \ / _ \ \ \ /\ / / _ \| '__| |/ _` | |
#|  _  | (_| | (__|   <  | |_| | | |  __/  \ V  V / (_) | |  | | (_| |_|
#|_| |_|\__,_|\___|_|\_\  \__|_| |_|\___|   \_/\_/ \___/|_|  |_|\__,_(_)
#-------------------------------------------------------------------------

echo -e "\nFINAL SETUP AND CONFIGURATION"
echo "--------------------------------------"
echo "-- GRUB EFI Bootloader Install&Check--"
echo "--------------------------------------"
if [[ -d "/sys/firmware/efi" ]]; then
    grub-install --efi-directory=/boot ${DISK}
fi
grub-mkconfig -o /boot/grub/grub.cfg

# ------------------------------------------------------------------------

echo -e "\nEnabling Login Display Manager"
systemctl enable sddm.service
echo -e "\nSetup SDDM Theme"
cat <<EOF > /etc/sddm.conf
[Theme]
Current=Nordic
EOF

# ------------------------------------------------------------------------

echo -e "\nEnabling essential services"

systemctl enable cups.service
ntpd -qg
systemctl enable ntpd.service
systemctl disable dhcpcd.service
systemctl stop dhcpcd.service
systemctl enable NetworkManager.service
systemctl enable bluetooth
echo "
###############################################################################
# Cleaning
###############################################################################
"
# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Replace in the same state
cd $pwd
echo "
###############################################################################
# Done - Please Eject Install Media and Reboot
###############################################################################
"
