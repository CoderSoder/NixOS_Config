# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

## GLOBAL SCOPE ##
{

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
  networking.enableIPv6 = false; ## Toggle IPv6 Address##

  ## Set Timezone ##
   time.timeZone = "Australia/Brisbane";

  ## Configure Network Proxy if Necessary ##
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select Internationalisation Properties ##
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
  ark
  htop
	git
	wget
	curl
	neofetch
	gparted
  bleachbit
  czkawka
	librewolf
	tor-browser-bundle-bin
	vscodium
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

   ];

# Enable Pipewire Audio ## 

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
  
  ## Enable CUPS to print documents ##
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  ## Libvirt Daemon ##
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  ## Gnome-Keyring Service ##
  services.gnome.gnome-keyring.enable = true;

  ## Wayland Screen Sharing ##
  xdg.portal.wlr.enable = true;

  ## Enable the OpenSSH daemon ##
   # services.openssh.enable = true;


  # Some programs need SUID wrappers, can be configured further or are started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "nixos-unstable"; # Did you read the comment?

}
