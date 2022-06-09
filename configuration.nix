{ config, pkgs, ... }:

{ 

#### READ HARDWARE ####
imports = [./hardware-configuration.nix];

#### Begin Config ####

#### ZRAM SETTINGS ####
zramSwap.enable = true;

#### BOOTLOADER SETTINGS ####
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

#### NETWORK SETTINGS ####
networking = {
hostName = "JC-PC";
 
networkmanager = {
enable = true;
dns = "dnsmasq";
 };
};
 
#### SSH SETTINGS ####
services.openssh.enable = true;
 
#### PRINTER SETTINGS ####
services.printing.enable = true;
services.avahi.enable = true;
services.avahi.nssmdns = true;
 
#### TIMEZONE ####
time.timeZone = "UTC";

#### LOCALE SETTINGS ####
i18n.defaultLocale = "en_US.UTF-8";
console.font = "Lat2-Terminus16";
console.keyMap = "us";

#### OPENGL DRIVERS ####
hardware.opengl.enable = true;
hardware.opengl.driSupport = true;
hardware.opengl.driSupport32Bit = true;
hardware.opengl.extraPackages = with pkgs; [libvdpau-va-gl vaapiVdpau];
hardware.opengl.extraPackages32 = with pkgs; [libvdpau-va-gl vaapiVdpau];

#### USER SETTINGS ####
users.users.jaiden = {
isNormalUser = true;
extraGroups = ["wheel" "libvirtd" "networkmanager"];
};

#### DISPLAY MANAGER ####
## LightDM & Greeters ##
services.xserver.displayManager.lightdm.enable = true;
services.xserver.displayManager.lightdm.greeters.gtk.enable = true;

#### DESKTOP ENVIROMENT ####
## Cinnamon Desktop ##
services.xserver.desktopManager.cinnamon.enable = true;
services.cinnamon.apps.enable = false;

#### AUDIO SETTINGS ####
security.rtkit.enable = true;
services.pipewire = {
enable = true;
alsa.enable = true;
alsa.support32Bit = true;
pulse.enable = true;
};

#### GLOBAL PACKAGES ####
environment.systemPackages = with pkgs; [

## System ##
neofetch
unzip
ark
gparted
bleachbit

## Development ##
git
vscodium

## Media ##
celluloid
qbittorrent

## Sandboxing / Virtualization ##
lutris-free
bottles
virt-manager
distrobox
	
## Theming ##	
## Icons ##
tela-circle-icon-theme
	
## Layan ##
layan-kde
layan-gtk-theme

## Materia ##
materia-kde-theme
materia-theme
];


#### EXTRA SERVICES ####
## Unfree Software ##
nixpkgs.config.allowUnfree = true;

## Enable Flatpak ##
services.flatpak.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 
## QEMU & Containers ##
virtualisation.libvirtd.enable = true;
programs.dconf.enable = true;
virtualisation.podman.enable = true;
virtualisation.podman.defaultNetwork.dnsname.enable = true;

## Gnome-Keyring Service ##
services.gnome.gnome-keyring.enable = true;

## Wayland Screen Sharing ##
xdg.portal.wlr.enable = true;

system.stateVersion = "22.11";
}
