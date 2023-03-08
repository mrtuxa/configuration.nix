# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.plymouth.enable = true;
  boot.cleanTmpDir = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-88acc3ee-36eb-4a99-bafe-2cf7ded3aa67".device = "/dev/disk/by-uuid/88acc3ee-36eb-4a99-bafe-2cf7ded3aa67";
  boot.initrd.luks.devices."luks-88acc3ee-36eb-4a99-bafe-2cf7ded3aa67".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.enable = true;
  hardware.gpgSmartcards.enable = true;
  security.rtkit.enable = true;
  security.doas.enable = true;
  security.tpm2.enable = true;
  security.chromiumSuidSandbox.enable = true;
  security.sudo.enable = false;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mrtuxa = {
    isNormalUser = true;
    description = "mrtuxa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      mpv
      element-desktop
      thunderbird
      #neofetch
      #bitwarden-cli
      #nload 
   ];
  };
  users.motd = "Welcome home Sir, feel free to take a cup of coffee";
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =  [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     pkgs.vim
     pkgs.wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

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
  system.stateVersion = "22.11"; # Did you read the comment?

hardware.firmware = [ pkgs.rtw89-firmware ];
boot.extraModulePackages = with config.boot.kernelPackages; [ rtw89 ];
  programs.steam.enable = true;
  programs.htop.enable = true;
  programs.git.enable = true;
  programs.vim.package = pkgs.vim;
  programs.gnupg.agent.enable = true;
  programs.kdeconnect.enable = true;
  programs.noisetorch.enable = true;
  programs.command-not-found.enable = true;
  programs.firefox.enable = true;
  programs.npm.enable = true;
  programs.zsh.ohMyZsh.cacheDir = "$HOME/.cache/oh-my-zsh";
  programs.zsh.ohMyZsh.theme = "bira";
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.enable = true;
  programs.java.enable = true;
  programs.ccache.enable = false;
  programs.flashrom.enable = true;
  programs.gpaste.enable = true;
  programs.droidcam.enable = false;
  programs.fuse.userAllowOther = true;
  programs.iftop.enable = true;
  programs.gnome-disks.enable = true;
  programs.ausweisapp.enable = true;
  appstream.enable = true;
  powerManagement.enable = true;

}
