# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.enableIPv6 = false;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_TW.UTF-8";

  i18n.supportedLocales = [
    "zh_TW.UTF-8/UTF-8"
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "fr_FR.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_TW.UTF-8";
    LC_IDENTIFICATION = "zh_TW.UTF-8";
    LC_MEASUREMENT = "zh_TW.UTF-8";
    LC_MONETARY = "zh_TW.UTF-8";
    LC_NAME = "zh_TW.UTF-8";
    LC_NUMERIC = "zh_TW.UTF-8";
    LC_PAPER = "zh_TW.UTF-8";
    LC_TELEPHONE = "zh_TW.UTF-8";
    LC_TIME = "zh_TW.UTF-8";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chewing
    ];
    fcitx5.waylandFrontend = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # GNOME
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    geary # emails
    gnome-music
    epiphany # Web
  ]);

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Ollama
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # Open Web UI
  services.open-webui = {
    enable = true;
    port = 9543;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.powerOnBoot = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucas = {
    isNormalUser = true;
    description = "Lucas D.";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.chromium = {
    enable = true;
  };
  programs.nix-ld.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.packageOverrides = pkgs: {
  #  unstable = import <nixos-unstable> {
  #    config = config.nixpkgs.config;
  #  };
  #};

  # Insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.5.7"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
  let
    php = pkgs.php.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [
        xdebug
        xsl
      ]));
      extraConfig = ''
        short_open_tag = 0
        post_max_size = 2G
        memory_limit = 8G
        upload_max_filesize = 1800M
        xdebug.start_with_request=yes
        xdebug.mode=develop,debug,coverage
        xdebug.log_level=0
      '';
    };
  in [
    unstable.beekeeper-studio
    brave
    unstable.bun
    chromium
    clang
    unstable.code-cursor
    (callPackage ./dcsrs-to-pdf/default.nix {})
    dialog # displays dialog boxes from shell
    discord
    firefox
    evolution # emails
    ffmpeg-full
    filezilla
    gcc
    gimp
    git
    gnomeExtensions.system-monitor
    gnomeExtensions.alttab-scroll-workaround
    gnomeExtensions.appindicator
    gnomeExtensions.just-perfection
    gnomeExtensions.launch-new-instance
    gnomeExtensions.lock-keys
    gnomeExtensions.notification-timeout
    gnomeExtensions.panel-world-clock-lite
    gnomeExtensions.color-picker
    graphviz
    httpie
    hyperfine # CLI benchmarking tool
    imagemagick
    inxi # System information tool
    jq
    kdePackages.kdenlive
    unstable.laravel
    libreoffice-fresh
    lshw # Hardware information
    mailpit
    microsoft-edge
    nodejs_24
    nushell
    obs-studio
    openssl
    openvpn
    pciutils # Programs for inspecting and manipulating configuration of PCI devices
    php
    # phpPackages.composer
    (php.withExtensions ({ enabled, all }: enabled ++ [ all.xsl ])).packages.composer
    pnpm
    postman
    python3
    python311Packages.pip
    python311Packages.setuptools
    rustup
    stripe-cli
    tesseract
    unstable.symfony-cli
    vesktop
    vim
    vlc
    unstable.vscode
    wget
    yarn-berry
    zsh
    zsh-powerlevel10k
  ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      awesome
      corefonts
      nerd-fonts.fira-code
      liberation_ttf
      nerd-fonts.meslo-lg
      noto-fonts
      noto-fonts-cjk-sans
      roboto
    ];
  };

  # Chromium
  programs.chromium.extensions = [
    "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
    "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark reader
    "mlomiejdfkolichcflejclcbmpeaniij" # Ghostery
    "gphhapmejobijbbhgpjhcjognlahblep" # Gnome Shell integration
    "iokfkfickldinmejhpfcngiocoedkpkh" # LingLook
    "ldmgbgaoglmaiblpnphffibpbfchjaeg" # New TongWenTang
    "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
    "fmkadmapgofadopljbjfkapdkoienihi" # React Developer Tools
    "anmmhkomejbdklkhoiloeaehppaffmdf" # React Scan
    "fdnpgodccdfgofepkclnopmbnacjkbnj" # Pexels new tab images
    "gppongmhjkpfnbhagpmjfkannfbllamg" # Wappalyzer
  ];

  # ZSH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # GIT
  programs.git.config = {
    init = {
      defaultBranch = "main";
    };
  };

  # Docker
  virtualisation.docker.enable = true;
  #virtualisation.docker.rootless = {
  #  enable = true;
  #  setSocketVariable = true;
  #};

  # NVIDIA Graphics
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true; # Use NVidia open source kernel module
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  #hardware.nvidia.powerManagement.enable = true;
  #hardware.nvidia.powerManagement.finegrained = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.prime = {
    reverseSync.enable = true;
      
    intelBusId = "PCI:0@0:2:0";
    nvidiaBusId = "PCI:1@0:0:0";
  };

  # To make Chromium work on Wayland
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 51820 ];
    checkReversePath = false; # Don't block VPN traffic
    extraCommands = ''
      iptables -I INPUT 1 -s 172.16.0.0/12 -p tcp -d 172.17.0.1 -j ACCEPT
      iptables -I INPUT 2 -s 172.16.0.0/12 -p udp -d 172.17.0.1 -j ACCEPT
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

