{ config, pkgs, inputs, ... }:

{

  imports = [
	  inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.onedark;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dilip";
  home.homeDirectory = "/home/dilip";
  xdg.enable = true;
  home.pointerCursor = {
	 name = "Bibata-Modern-Ice";
	 package = pkgs.bibata-cursors;
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
	 enable = true;
	 theme.package = pkgs.adw-gtk3;
	 theme.name = "adw-gtk3";
	 iconTheme.package = pkgs.papirus-icon-theme;
	 iconTheme.name = "papirus-icon-theme";
  };
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };


  home.packages = [
	 pkgs.dconf
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
	 FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border";
  };
  home.shellAliases = {
	btop = "btop --utf-force";
  };

  xsession.windowManager.bspwm = {
    enable = true;
	 monitors = {
		Virtual1 = [
			"1" "2" "3" "4" "5" "6" "7" "8" "9"
		];
	 };
	 settings = {
		 border_width = 2;
		 border_radius = 12;
		 focus_follows_pointer = true;
		 window_gap = 10;
		 gapless_monocle = false;
		 borderless_monocle = false;
		 split_ratio = 0.52;
		 focused_border_color = "#${config.colorScheme.colors.base0D}";
	 };
	 extraConfig = ''
		wal -R
		./.fehbg
		./.config/polybar/launch.sh --forest & 
	 '';
  };

  programs.git = {
	 enable = true;
	 userName = "Dilip Chauhan";
	 userEmail = "chauhandilip305@gmail.com";
  };
  programs.fish = {
	enable = true;
  };
  programs.zoxide = {
    enable = true;
	 enableFishIntegration = true;
  };
  programs.starship = {
    enable = true;
	 enableFishIntegration = true;
  };
  programs.ncmpcpp = {
	 enable = true;
	 mpdMusicDir = "/home/dilip/Music";
	 settings = {
		 mpd_host = "127.0.0.1";
		 mpd_port = 6600;
		 mpd_crossfade_time = 2;
	 };
  };
  programs.zathura = {
    enable = true;
	 options = {
		 font = "Iosevka Nerd Font 9";

   	 # SETTINGS
		 window-height = 700;
		 window-width = 500;
		 adjust-open = "width";
		 page-padding = 8;
		 show-hidden = true;
		 statusbar-basename = true;
		 statusbar-home-tilde = true;
		 page-right-to-left = true;
		 recolor = true;
		 recolor-reverse-video = true;
		 selection-clipboard = "clipboard";

		 # HIGHLIGHTING
		 default-bg = "#${config.colorScheme.colors.base00}";
		 default-fg = "#${config.colorScheme.colors.base07}";
		 notification-bg = "#${config.colorScheme.colors.base00}";
		 notification-fg = "#${config.colorScheme.colors.base07}";
		 notification-warning-bg = "#${config.colorScheme.colors.base0A}";
		 notification-warning-fg = "#${config.colorScheme.colors.base07}";
		 notification-error-bg = "#${config.colorScheme.colors.base08}";
		 notification-error-fg = "#${config.colorScheme.colors.base07}";
		 statusbar-bg = "#${config.colorScheme.colors.base00}";
		 statusbar-fg = "#${config.colorScheme.colors.base07}";
		 input-bg = "#${config.colorScheme.colors.base00}";
		 input-fg = "#${config.colorScheme.colors.base07}";
		 index-bg = "#${config.colorScheme.colors.base00}";
		 index-fg = "#${config.colorScheme.colors.base07}";
		 index-active-bg = "#${config.colorScheme.colors.base0D}";
		 index-active-fg = "#${config.colorScheme.colors.base00}";
		 completion-bg = "#${config.colorScheme.colors.base00}";
		 completion-fg = "#${config.colorScheme.colors.base07}";
		 completion-group-bg = "#${config.colorScheme.colors.base00}";
		 completion-group-fg = "#${config.colorScheme.colors.base09}";
		 completion-highlight-bg = "#${config.colorScheme.colors.base07}";
		 completion-highlight-fg = "#${config.colorScheme.colors.base00}";
		 render-loading-bg = "#${config.colorScheme.colors.base00}";
		 render-loading-fg = "#${config.colorScheme.colors.base07}";
		 recolor-lightcolor = "#${config.colorScheme.colors.base00}";
		 recolor-darkcolor = "#${config.colorScheme.colors.base07}";
	 };
	 mappings = {
		 K = "navigate previous";
		 J = "navigate next";
		 D = "toggle_page_mode";
		 b = "toggle_statusbar";
		 P = "print";
		 r = "reload";
		 R = "rotate";
		 "+" = "zoom in";
		 "-" = "zoom out";
		 d = "recolor";
		 "<C-q>" = "quit";
	 };
  };

  services.dunst = {
	 enable = true;
	 settings = {
		global = {
			monitor = 0;
			follow = "mouse";
			width = 300;
			height = 100;
			offset = "10x50";
			origin = "top-right";
			transparency = 0;
			frame_color = "#${config.colorScheme.colors.base0D}";
			separator_color = "#${config.colorScheme.colors.base00}";
			progress_bar = true;
			progress_bar_height = 10;
			progress_bar_frame_width = 1;
			progress_bar_min_width = 50;
			progress_bar_max_width = 280;
			highlight = "#${config.colorScheme.colors.base02}";
			notification_height = 0;
			shrink = true;
			separator_height = 5;
			padding = 15;
			horizontal_padding = 10;
			frame_width = 2;
			font = "Iosevka Nerd Font 9";
			line_height = "1.2";
			sort = true;
			markup = "yes";
          # The format of the message.  Possible variables are:
          #   %a  appname
          #   %s  summary
          #   %b  body
          #   %i  iconname (including its path)
          #   %I  iconname (without its path)
          #   %p  progress value if set ([  0%] to [100%]) or nothing
          # Markup is allowed
          format = ''
            <b>%a</b>
				%s
            %b'';
			alignment = "center";
			vertical_alignment = "center";
			show_age_threshold = 60;
			word_wrap = true;
			ellipsize = "middle";
			ignore_newline = false;
			stack_duplicates = true;
			hide_duplicate_count = true;
			show_indicators = true;
			icon_position = false;
			min_icon_size = 16;
			max_icon_size = 32;
		};
		urgency_low = {
			background = "#${config.colorScheme.colors.base00}";
			foreground = "#${config.colorScheme.colors.base07}";
			timeout = 3;
		};
		urgency_normal = {
			background = "#${config.colorScheme.colors.base00}";
			foreground = "#${config.colorScheme.colors.base07}";
			timeout = 3;
		};
		urgency_critical = {
			background = "#${config.colorScheme.colors.base00}";
			foreground = "#${config.colorScheme.colors.base08}";
			timeout = 10;
		};
	 };
  };
  services.picom = {
	 enable = true;
	 shadow = false;
	 opacityRules = [];
	 settings = {};
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "23.05"; # Please read the comment before changing.
}
