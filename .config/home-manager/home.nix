{ config, pkgs, inputs, ... }:

{

  imports = [
	  inputs.nix-colors.homeManagerModules.default
  ];

  # colorScheme = inputs.nix-colors.colorSchemes.onedark;
	colorScheme = {
		slug = "cyberpunk";
		name = "Cyberpunk";
		author = "Dilip Chauhan";
		colors = {
		base00 = "#08011a";
		base01 = "#ff184c";
		base02 = "#13b935";
		base03 = "#f8cd2c";
		base04 = "#3a3c95";
		base05 = "#7c0f95";
		base06 = "#00c37a";
		base07 = "#9b9dba";
		base08 = "#111141";
		base09 = "#ff577d";
		base0A = "#1afe49";
		base0B = "#f8cd2c";
		base0C = "#4b4bd7";
		base0D = "#a610c6";
		base0E = "#00ff9f";
		base0F = "#cfcfde";
		};
	};

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username                    = "dilip";
  home.homeDirectory               = "/home/dilip";
  xdg.enable                       = true;
  xdg.configFile."lf/icons".source = ./icons;
  home.pointerCursor = {
	 name    = "Bibata-Modern-Ice";
	 package = pkgs.bibata-cursors;
    size       = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
	 enable            = true;
	 theme.package     = pkgs.adw-gtk3;
	 theme.name        = "adw-gtk3";
	 iconTheme.package = pkgs.papirus-icon-theme;
	 iconTheme.name    = "papirus-icon-theme";
  };
  qt = {
    enable        = true;
    platformTheme = "gnome";
    style = {
      name    = "adwaita-dark";
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
  };
  home.shellAliases = {
		btop = "btop --utf-force";
  };

  xsession.windowManager.bspwm = {
    enable = true;
		monitors   = {
		Virtual1   = [
			"1" "2" "3" "4" "5" "6" "7" "8" "9"
		];
	 };
	 settings = {
		 border_width          = 1;
		 border_radius         = 12;
		 focus_follows_pointer = true;
		 window_gap            = 16;
		 gapless_monocle       = false;
		 borderless_monocle    = false;
		 split_ratio           = 0.52;
		 focused_border_color  = "#${config.colorScheme.colors.base0E}";
		 # focused_border_color  = "#a610c6";
	 };
	 rules = {
		 "org.wezfurlong.wezterm" = {
			 desktop = "^1";
			 follow = true;
		 };
	 };
	 extraConfigEarly = ''
		 bash ~/.cache/wal/colors.sh
		 notify-send -a "home" "$color4"
	 '';
	 extraConfig = ''
		wal -R
		./.fehbg
		./.config/polybar/cyberpunk/launch.sh bspwm-bar &
		# ./.config/polybar/launch.sh --cuts & 
	 '';
  };

	programs.eww = {
		enable = true;
		configDir = ./eww;
	};
  programs.eza = {
	 enable        = true;
	 enableAliases = true;
	 git           = true;
	 icons         = true;
  };
  programs.fzf = {
		enable                = true;
		enableFishIntegration = true;
		colors                = {};
		defaultOptions = [
			"--height 40%" 
			"--layout=reverse"
			"--border"
	 ];
  };
  programs.git = {
	 enable    = true;
	 userName  = "Dilip Chauhan";
	 userEmail = "chauhandilip305@gmail.com";
  };
  programs.fish = {
		enable = true;
  };
  programs.zoxide = {
		enable                = true;
		enableFishIntegration = true;
  };
  programs.starship = {
    enable = true;
		enableFishIntegration = true;
  };
  programs.ncmpcpp = {
	 enable      = true;
	 mpdMusicDir = "/home/dilip/Music";
	 settings    = {
		 mpd_host           = "127.0.0.1";
		 mpd_port           = 6600;
		 mpd_crossfade_time = 2;
	 };
  };
  programs.zathura = {
    enable = true;
		options = {
			font = "Iosevka Nerd Font 12";

			# SETTINGS
			window-height         = 700;
			window-width          = 500;
			adjust-open           = "width";
			page-padding          = 8;
			show-hidden           = true;
			statusbar-basename    = true;
			statusbar-home-tilde  = true;
			page-right-to-left    = true;
			recolor               = true;
			recolor-reverse-video = true;
			selection-clipboard   = "clipboard";

		 # HIGHLIGHTING
		 default-bg              = "#${config.colorScheme.colors.base00}";
		 default-fg              = "#${config.colorScheme.colors.base07}";
		 notification-bg         = "#${config.colorScheme.colors.base00}";
		 notification-fg         = "#${config.colorScheme.colors.base07}";
		 notification-warning-bg = "#${config.colorScheme.colors.base0A}";
		 notification-warning-fg = "#${config.colorScheme.colors.base07}";
		 notification-error-bg   = "#${config.colorScheme.colors.base08}";
		 notification-error-fg   = "#${config.colorScheme.colors.base07}";
		 statusbar-bg            = "#${config.colorScheme.colors.base00}";
		 statusbar-fg            = "#${config.colorScheme.colors.base07}";
		 input-bg                = "#${config.colorScheme.colors.base00}";
		 input-fg                = "#${config.colorScheme.colors.base07}";
		 index-bg                = "#${config.colorScheme.colors.base00}";
		 index-fg                = "#${config.colorScheme.colors.base07}";
		 index-active-bg         = "#${config.colorScheme.colors.base0D}";
		 index-active-fg         = "#${config.colorScheme.colors.base00}";
		 completion-bg           = "#${config.colorScheme.colors.base00}";
		 completion-fg           = "#${config.colorScheme.colors.base07}";
		 completion-group-bg     = "#${config.colorScheme.colors.base00}";
		 completion-group-fg     = "#${config.colorScheme.colors.base09}";
		 completion-highlight-bg = "#${config.colorScheme.colors.base07}";
		 completion-highlight-fg = "#${config.colorScheme.colors.base00}";
		 render-loading-bg       = "#${config.colorScheme.colors.base00}";
		 render-loading-fg       = "#${config.colorScheme.colors.base07}";
		 recolor-lightcolor      = "#${config.colorScheme.colors.base00}";
		 recolor-darkcolor       = "#${config.colorScheme.colors.base07}";
	 };
	 mappings = {
		 K       = "navigate previous";
		 J       = "navigate next";
		 D       = "toggle_page_mode";
		 b       = "toggle_statusbar";
		 P       = "print";
		 r       = "reload";
		 R       = "rotate";
		 "+"     = "zoom in";
		 "-"     = "zoom out";
		 d       = "recolor";
		 "<C-q>" = "quit";
	 };
  };
  programs.firefox = {
    enable = true;
    profiles."4ige6zxl.default" = {

      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };
      };
      search.force = true;

      bookmarks = [
        {
          name    = "wikipedia";        
          tags    = [ "wiki" ];        
          keyword = "wiki";           
          url     = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
      ];

      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled"  = false;
        "signon.rememberSignons"       = false;
				"layout.show_previous_page"		 = true;
      };

      userChrome = ''                         
        /* some css */                        
      '';                                      

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
				darkreader
				pywalfox
      ];

    };
  };
	programs.yazi = {
		enable = true;
		enableFishIntegration = true;
		settings = {
			manager = {
			  ratio = [ 1 4 3 ];
				sort_by = "alphabetical";
				sort_reverse = false;
				sort_dir_first = true;
				line_mode = "permissions";
				show_hiddern = false;
			};
			input = {
			 origin = "center";
			};
			select = {
				origin = "center";
			};
			open = {
				rules = [
				{ mime = "text/*"; use = "text"; }
				{ mime = "image/*"; use = "image"; }

				# { mime = "application/json", use = "text" }
				{ name = "*.json"; use = "text"; }

				# Multiple openers for a single rule
				{ name = "*.html"; use = [ "browser" "text" ]; }
				];
			};
			opener = {
			 #  text = [
				#   { exec = 'nvim "$@"'; block = true; }
				# ];
			};
		};
		theme = {};
		keymap = {
			# input.keymap = [
			# 	{ exec = "close"; on = [ "<c-q>" ]; }
			# 	{ exec = "close --submit"; on = [ "<enter>" ]; }
			# 	{ exec = "escape"; on = [ "<esc>" ]; }
			# 	{ exec = "backspace"; on = [ "<backspace>" ]; }
			# ];
			# manager.keymap = [
			# 	{ exec = "escape"; on = [ "<esc>" ]; }
			# 	{ exec = "quit"; on = [ "q" ]; }
			# 	{ exec = "close"; on = [ "<c-q>" ]; }
			# ];
		};
	};

	services.betterlockscreen = {
		enable = true;
		arguments = [ "blur" ];
	};
  services.dunst = {
	 enable   = true;
	 settings = {
		global = {
			monitor = 0;
			follow = "mouse";
			width = 300;
			height = 100;
			offset = "10x50";
			origin = "top-right";
			transparency = 0;
			frame_color = "#${config.colorScheme.colors.base0E}";
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
			frame_width = 1;
			font = "Iosevka Nerd Font 10";
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
			foreground = "#${config.colorScheme.colors.base09}";
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
	services.mpd = {
		enable = true;
		musicDirectory = "~/Music/";
		extraConfig = ''
			audio_output {
				type "pulse"
				name "My PuleseAudio"
			}
		'';

	};
	services.sxhkd = {
	  enable = true;
		keybindings = {
			"super + Return" = "wezterm";		# launch terminal
			"super + d" = "rofi -show drun -theme ~/.config/rofi/cyberpunk/launcher.rasi";
			"super + shift + q" = "./.config/rofi/cyberpunk/powermenu.sh";
			"Print" = "maim ~/Pictures/screenshots/maim_$(date +%d%m%Y_%H%M%S).png && dunstify -a 'Scrot' 'Screenshot saved.' -i '~/Pictures/Scrot/$1' -t 2000";
			"super + Escape" = "pkill -USR1 -x sxhkd";
			# close and kill
			"super + q" = "bspc node -c";

			# restart bspwm
			"super + shift + r" = "bspc wm -r";
			# alternate between the tiled and monocle layout
			"super + m" = "bspc desktop -l next";
			# send the newest marked node to the newest preselected node
			"super + y" = "bspc node newest.marked.local -n newest.!automatic.local";
			# swap the current node and the biggest window
			"super + shift + s" = "bspc node -s biggest.window.local";
			"super + {_,shift +}z" = "bspc config window_gap {10,20}";

			# set the window state
			"super + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
			# set the node flags
			"super + ctrl + {v,l,s,p}" = "bspc node -g {marked,locked,sticky,private}";

			# focus the node in the given direction
			"super + {_,shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
			# focus the node for the given path jump
			"super + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";
			# focus the next/previous window in the current desktop
			"super + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";
			# focus/send to the next/previous desktop in the current monitor
			"super + {_,shift + }bracket{left,right}" = "bspc {desktop -f,node -d} {prev,next}.local";
			# focus the last node/desktop
			"{super,alt} + Tab" = "bspc {desktop,node} -f last";
			# focus or send to the given desktop
			"super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";

			# preselect the direction
			"super + ctrl + {h,j,k,l}" = "bspc node -p {west,south,north,east}";
			# preselect the ratio
			"super + ctrl + {1-9}" = "bspc node -o 0.{1-9}";
			# cancel the preselection for the focused node
			"super + ctrl + space" = "bspc node -p cancel";
			# cancel the preselection for the focused desktop
			"super + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

			# expand a window by moving one of its side outward
			"super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
			# contract a window by moving one of its side inward
			"super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
			# move a floating window
			"super + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
		};
	};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "23.05"; # Please read the comment before changing.
}
