# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

## GLOBAL SCOPE ##
networking.enableIPv6 = false;

## Toggle Unfree Software ##
nixpkgs.config.allowUnfree = true;

## Toggle Software Repo ##
system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable/;

## Toggle Automatic Updates ##
system.autoUpgrade.enable = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "JC-PC"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Australia/Brisbane";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     # keyMap = "us";
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
     enable = true;
     greeters.pantheon.enable = true;
   };

   gdm = {
     enable = false;
   }; 

   sddm = {
     enable = false;
      };

    };

  };

};


  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.jaiden = {
     isNormalUser = true;
     extraGroups = [ "wheel" "libvirtd" "networkmanager"];
   };



  ## Global Packages ##
 environment.systemPackages = with pkgs; [
 	kitty
	git
	wget
	curl
	neofetch
	gparted
	bleachbit
	cinnamon.nemo
	librewolf
	tor-browser-bundle-bin
	vscodium
	bottles
	flatpak
	virt-manager
   ];

 ## Qt5 GTK Theming ## 
 	qt5.enable = true;
	qt5.platformTheme = "gtk2";
	qt5.style = "gtk2";
 
  ## System Services ##

  ## Enable Flatpak ##
   # services.flatpak.enable = true;
   # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  ## Enable CUPS to print documents ##
   services.printing.enable = true;

  ## Libvirt daemon ##
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  ## Gnome-keyring service ##
  services.gnome.gnome-keyring.enable = true;
  
  ## OpenCL Support (AMD & INTEL) ##
  ## Only Enable One ##
     hardware.opengl.extraPackages = [   
     	rocm-opencl-icd ## AMD GPU
	# intel-compute-runtime ## INTEL GPU
   ];
  
  ## Vulkan Support (AMD) ##
  hardware.opengl.extraPackages = [
  pkgs.amdvlk
];

 ## Vulkan 32-Bit Support (AMD) ##
      hardware.opengl.extraPackages32 = [
      	pkgs.driversi686Linux.amdvlk
    ];

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
  system.stateVersion = "22.05"; # Did you read the comment?

}
