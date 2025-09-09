# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./drives.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  boot.supportedFilesystems = [ "ntfs" ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "tian";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "dvp";
  };
  console.keyMap = "dvorak-programmer";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cosmos = {
    isNormalUser = true;
    description = "Wenhan Zhu";
    extraGroups = [ "networkmanager" "wheel" "docker" "sambashare" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    dua
    duf
    gcc
    git
    htop
    iperf3
    lm_sensors
    mergerfs
    neovim
    python3
    ranger
    smartmontools
    stow
    tmux
    uv
    vim
    wget
  ];

  environment.enableAllTerminfo = true;

  # List services that you want to enable:
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };
  services.tailscale.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = let 
      mkShare = path: {
        path = path;
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "cosmos";
        "force group" = "users"; 
        "valid users" = "cosmos"; 
      };
      mkPubShare = path: {
        path = path;
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
        "force user" = "cosmos";
        "force group" = "users"; 
        "follow symlinks" = "yes";
        "wide links" = "yes";
      };
    in {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "tian";
        "netbios name" = "tian";
        "security" = "user";
        "guest ok" = "no";
        "map to guest" = "bad user";
        "guest account" = "nobody";
        "access based share enum" = "yes";
        "allow insecure wide links" = "yes";
      };
      jbod = mkShare "/mnt/jbod";
      jbod-public = mkPubShare "/mnt/jbod/PTDownloads/public";
      "disk-14t-03105900" = mkShare "/mnt/drives/disk-14t-03105900/Share";
      "disk-14t-b29daf5a" = mkShare "/mnt/drives/disk-14t-b29daf5a/Share";
      "disk-14t-ddc2e295" = mkShare "/mnt/drives/disk-14t-ddc2e295/Share";
      "disk-14t-f69b4d14" = mkShare "/mnt/drives/disk-14t-f69b4d14/Share";
      "disk-16t-5b113a07" = mkShare "/mnt/drives/disk-16t-5b113a07/Share";
      "disk-1t-604484AA" = mkShare "/mnt/drives/disk-1t-604484AA";
      "disk-2t-7C1085E5" = mkShare "/mnt/drives/disk-2t-7C1085E5";
      "disk-4t-88769c7b" = mkShare "/mnt/drives/disk-4t-88769c7b";
      "disk-8t-67752f4f" = mkShare "/mnt/drives/disk-8t-67752f4f/Share";
      "disk-8t-faf54a36" = mkShare "/mnt/drives/disk-8t-faf54a36/Share";
      "nvme-disk-1t-704b0b83" = mkShare "/mnt/drives/nvme-disk-1t-704b0b83/Share";
    };
  };

  services.avahi = {
    enable = true;
    openFirewall = true;
    publish.enable = true;
    publish.userServices = true;
    nssmdns4 = true;
  };

  system.stateVersion = "25.05";

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # For iperf testing purposes
  networking.firewall.allowedTCPPorts = [ 5201 6800 6888 ];
  networking.firewall.allowedUDPPorts = [ 5201 6888 ];

}
