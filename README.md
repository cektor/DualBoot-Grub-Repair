# DualBoot-Grub-Repair
 This script automates GRUB management tasks on a Linux system. It updates GRUB, reinstalls it if missing, and adds Windows to the GRUB menu if detected. It also checks for the presence of Windows partitions and asks the user to reboot after completing the operations. Requires root privileges for execution.

# Functions:
GRUB Update (update_grub): This function runs the sudo update-grub command to update the GRUB configuration and apply changes to the GRUB menu.

Reinstall GRUB (reinstall_grub): This function reinstalls GRUB using the sudo grub-install command. It is used when GRUB is not installed correctly, and then the update-grub function is called to update the configuration.

Add Windows to GRUB (add_windows_to_grub): This function uses os-prober to detect operating systems on the system and add any detected Windows installations to the GRUB configuration.

Check for Windows (check_windows): This function checks for NTFS partitions (Windows typically uses the NTFS file system). If a Windows partition is found, it calls add_windows_to_grub to add Windows to the GRUB menu.

Check for GRUB (check_grub): This function checks if GRUB is installed on the system. If GRUB is not found, it calls the reinstall_grub function to reinstall it.

Ask for Reboot (ask_for_reboot): This function asks the user if they want to reboot the system after changes have been made. If the user agrees, the system will reboot.

Main Function (main): This function calls the above operations sequentially to check the GRUB configuration, add Windows if detected, and then ask the user whether to reboot the system.


# Note:
In some Linux distributions, Grub is updated after a Kernel update and sometimes Windows BootLoader is deleted from Grub. Run this Shell Script without rebooting the system after the Kernel Update and avoid DualBoot Error.

# Install Git Clone 

Github Package Must Be Installed On Your Device.
```bash
sudo apt install git  -y
```

----------------------------------

# Installation ShellScript
```bash
sudo git clone https://github.com/cektor/DualBoot-Grub-Repair.git
```
```bash
cd BreadcrumbsDualBoot-Grub-Repair
```
```bash
sudo chmod +x gdboot-r.sh
```
```bash
sudo ./gdboot-r.sh
```
or

```bash
sudo bash gdboot-r.sh
```
