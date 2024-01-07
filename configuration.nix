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
  boot.plymouth.enable = true;
  boot.plymouth.themePackages = [ pkgs.adi1090x-plymouth-themes ];
  boot.plymouth.theme = "angular";

  networking.hostName = "TechnicalDC"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

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
    desktopManager.xterm.enable = false;
    displayManager = {
      defaultSession = "none+bspwm";
      autoLogin = {
	enable = true;
	user = "dilip";
      };
      sddm = {
	enable = true;
	theme = "${import ./sddm.nix { inherit pkgs; }}";
      };
      setupCommands = ''
	      ${pkgs.xorg.xrandr}/bin/xrandr --output Virtual1 --mode 1920x1080 --pos 0x0 --rotate normal
      '';

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
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false; # .desktop
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	arandr
	bat
	betterlockscreen
	btop
	conky
	# dunst
	feh
	firefox
	fishPlugins.fzf
	# fzf
	gh
	gimp-with-plugins
	glow
	gnugrep
	gum
	home-manager
	hugo
	instaloader
	killall
	lf
	libgcc
	libsForQt5.qt5.qtquickcontrols
	libsForQt5.qt5.qtgraphicaleffects
	libnotify
	lxappearance
	maim
	mpc-cli
	mpd
	mpv
	mpvc
	ncdu_1
	ncmpcpp
	neofetch
	neovim
	nsxiv
	newsboat
	nodejs_20
	polkit_gnome
	polybarFull
	python311Packages.pip
	pywal
	ripgrep
	rofi
	# starship
	telegram-desktop
	tldr
	trash-cli
	wezterm
	wget
	xclip
	# zathura
	# zoxide
  ];
  environment.shellAliases = {
	ll = "ls -l";
	btop = "btop --utf-force";
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

   xdg.portal = {
       enable = true;
       # wlr.enable = true;
       # gtk portal needed to make gtk apps happy
       extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions
  programs.kdeconnect.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # services.picom.enable = true;
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
  	 network = {
		listenAddress = "127.0.0.1";
		port = 6600;
	 };
	 extraConfig = ''
		 audio_output {
			 type "pulse"
			 name "My PulseAudio" # this can be whatever you want
		 }
	 '';

  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.11"; # Did you read the comment?

}
