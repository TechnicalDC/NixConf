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
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "TechnicalDC"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager = {
      sddm = {
	enable = true;
      };
    };
  };
  services.xserver.windowManager = {
	qtile = {
		enable = true;
	};
  	bspwm = {
		enable = true;
		configFile = "/home/dilip/.config/bspwm/bspwmrc";
		sxhkd.configFile = "/home/dilip/.config/sxhkd/sxhkdrc";
	};
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dilip = {
    isNormalUser = true;
    description = "dilip";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	arandr
	bat
	btop
	dunst
	feh
	firefox
	fishPlugins.fzf
	fzf
	git
	glow
	gum
	instaloader
	killall
	lf
	mpc-cli
	mpd
	mpv
	mpvc
	ncdu_1
	ncmpcpp
	neofetch
	neovim
	newsboat
	nodejs_20
	polybarFull
	python311Packages.pip
	pywal
	rofi
	starship
	telegram-desktop
	tldr
	wezterm
	wget
	zathura
	zoxide
  ];
  environment.shellAliases = {
	ll = "ls -l";
  };
  environment.sessionVariables = {
	FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border";
  };

  fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  nerdfonts
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions
  programs.starship = {
  	enable = true;
	interactiveOnly = true;
  };
  programs.fish = {
  	enable = true;
  };
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.picom.enable = true;
  services.locate = {
  	enable = true;
  	interval = "hourly";
  };
  services.mpd = {
	enable = true;
	user = "dilip";
	group = "users";
	dbFile = "/home/dilip/.config/mpd/mpd.db";
	musicDirectory	= "/home/dilip/Music";
	playlistDirectory = "/home/dilip/Music/Playlist";
  };

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
