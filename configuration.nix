# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

## GLOBAL SCOPE ##
{

## Enable ZRAM ##
zramSwap.enable = true;

## Toggle Unfree Software ##
nixpkgs.config.allowUnfree = true;

## Toggle Software Repo ##
system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable/;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  ## Use systemd-boot EFI Boot Loader ##
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ## Networking ##
  networking.hostName = "JC-PC"; ## Define Hostname ##
  networking.networkmanager.enable = true; ## Toggle Network Manager ##
  services.https-dns-proxy.enable = true; ## Toggle DNS Over HTTPS Proxy ##
  services.https-dns-proxy.provider.kind = "quad9"; ## DNS Over HTTPS Provider ##
  services.https-dns-proxy.preferIPv4 = true; ## Prefer IPv4 For DNS Proxy ##
  networking.enableIPv6 = false; ## Toggle IPv6 Address ##
  
  ## Enable Firewall ##
  networking.firewall.enable = true;
  
  ## Enable OpenSSH ##
  services.openssh.enable = true;
  
  ## Enable CUPS to print documents ##
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  
  ## Set Timezone ##
   time.timeZone = "Australia/Brisbane";

  ## Configure Network Proxy if Necessary ##
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ## Select Internationalisation Properties ##
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

services = {

## Default App Toggle ##
  pantheon.apps.enable = false;
  gnome.core-utilities.enable = false;

xserver = {
## Enable X11 Server ##
    enable = true;

## X11 Keymap ##
  layout = "us";

## Desktop Enviroments ##
  desktopManager = {

  pantheon = {
    enable = false;
  }; 

   gnome = {
    enable = false;    
  };

   plasma5 = {
     enable = true;
  };
};

## Display Managers ##
displayManager = {

   lightdm = {
     enable = false;
     greeters.pantheon.enable = false;
     greeters.gtk.enable = false;
   };

   gdm = {
     enable = false;
   }; 

   sddm = {
     enable = true;
      };

    };

  };

};

  ## Define User ##
   users.users.jaiden = {
     isNormalUser = true;
     extraGroups = [ "wheel" "libvirtd" "networkmanager"];
   };



  ## Global Packages ##
 environment.systemPackages = with pkgs; [
 	kitty
	kitty-themes
	neofetch
	htop
	git
	woeusb-ng
	ark
	gparted
	bleachbit
	elementary-planner
	librewolf-wayland
	vscodium
	tor-browser-bundle-bin
	qbittorrent
	libreoffice-fresh
	bottles
	virt-manager

	## GPU Drivers & API's ##
	
	## AMD Vulkan (64-Bit) ##
	amdvlk 
	
	## AMD Vulkan (32-Bit) ##
	driversi686Linux.amdvlk 
	
	## OpenCL (AMD) ##
	rocm-opencl-icd 
	
	## OpenCL (Intel) ##
	# intel-compute-runtime 

	## Qt / GTK Themes
	layan-kde
	layan-gtk-theme
   ];

## Pipewire Audio ## 
 security.rtkit.enable = true;
 services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ## System Services ##

  ## Enable Flatpak ##
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  ## Libvirt Daemon ##
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  ## Gnome-Keyring Service ##
  services.gnome.gnome-keyring.enable = true;

  ## Wayland Screen Sharing ##
  xdg.portal.wlr.enable = true;

  system.stateVersion = "22.05";
}
