{
  description = "My Darwin Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils-plus.url = "github:gytis-ivaskevicius/flake-utils-plus";
    nix-update.url = "github:Mic92/nix-update";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, flake-utils-plus, nix-update, flake-parts }:
  let
    configuration = { pkgs, config, ... }: {

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.act
          pkgs.ansible
          pkgs.ansible-lint
          pkgs.atuin
          pkgs.bash
          pkgs.bat
          pkgs.chezmoi
          pkgs.cmatrix
          pkgs.direnv
          pkgs.dotenvx
          pkgs.editorconfig-checker
          pkgs.eza
          pkgs.facter
          pkgs.fd
          pkgs.fzf
          pkgs.gh
          pkgs.git
          pkgs.git-ignore
          pkgs.git-lfs
          pkgs.diff-so-fancy
          pkgs.gitleaks
          pkgs.go
          pkgs.httrack
          pkgs.hugo
          pkgs.imagemagick
          pkgs.iperf
          pkgs.jinja2-cli
          pkgs.jq
          pkgs.kompose
          pkgs.kubectl
          pkgs.kubectx
          pkgs.kubernetes-helm
          pkgs.lazydocker
          pkgs.lazygit
          pkgs.lexicon
          pkgs.libusb1
          pkgs.m-cli
          pkgs.mkalias
          pkgs.nanorc
          pkgs.neovim
          pkgs.nicotine-plus
          pkgs.nix-update
          pkgs.nmap
          pkgs.packer
          pkgs.pandoc
          pkgs.pls
          pkgs.pre-commit
          pkgs.prettierd
          pkgs.prettyping
          pkgs.python312
          pkgs.python312Packages.pip
          pkgs.python313
          pkgs.qemu
          pkgs.ripgrep
          pkgs.rmlint
          pkgs.rsync
          pkgs.starship
          pkgs.tcpdump
          pkgs.terraform
          pkgs.thefuck
          pkgs.tldr
          pkgs.tmux
          pkgs.tmuxinator
          pkgs.topgrade
          pkgs.tor
          pkgs.treefmt
          pkgs.trufflehog
          pkgs.tuir
          pkgs.vault
          pkgs.vault-bin
          pkgs.vault-unseal
          pkgs.wget
          pkgs.yq
          pkgs.yt-dlp
          pkgs.zoxide
          pkgs.zsh
          pkgs.zsh-abbr
          pkgs.zsh-autocomplete
          pkgs.zsh-autopair
          pkgs.zsh-autosuggestions
          pkgs.zsh-clipboard
          pkgs.zsh-command-time
          pkgs.zsh-completions
          pkgs.zsh-defer
          pkgs.zsh-forgit
          pkgs.zsh-fzf-tab
          pkgs.zsh-history-substring-search
          pkgs.zsh-syntax-highlighting
          pkgs.zsh-you-should-use
          pkgs.zsh-z
          pkgs.zsh-zhooks
      ];

      # Fix for nixbld group GID mismatch
      ids.gids.nixbld = 350;

      # Add a system activation script to install MCP servers using pip
      system.activationScripts.installMcpServers.text = ''
        ${pkgs.python312}/bin/pip install --break-system-packages mcp-server-fetch
      '';

      homebrew = {
        enable = true;
        brews = [
          # "bitwarden-cli"
          "git-delta"
          "homebrew-ffmpeg/ffmpeg/ffmpeg"
          "incus"
          "mas"
          "node"
          "ntfy"
          "nvm"
          "qt"
          "vault-radar"
        ];
        casks = [
          # "airbattery"
          # "alacritty"
          "alfred"
          "alt-tab"
          # "altserver"
          # "applite"
          # "arc"
          "audacity"
          "balenaetcher"
          "bartender"
          # "battle-net"
          # "beaver-notes"
          # "bettertouchtool"
          # "bitwarden"
          "blender"
          # "brave-browser"
          "browserosaurus"
          # "calibre"
          # "cerebro"
          # "cork"
          "cursor"
          # "cutter"
          "daisydisk"
          "dangerzone"
          "darktable"
          "deezer"
          # "deskpad"
          "discord"
          # "dockdoor"
          "docker"
          # "double-commander"
          # "epic-games"
          "espanso"
          "finicky"
          # "flameshot"
          # "flowvision"
          "font-code-new-roman-nerd-font"
          "font-comic-shanns-mono-nerd-font"
          "font-fira-code-nerd-font"
          "font-fira-code"
          "font-geist-mono-nerd-font"
          "font-hack-nerd-font"
          "font-jetbrains-mono"
          "font-meslo-lg-nerd-font"
          "font-symbols-only-nerd-font"
          "freecad"
          # "furtherance"
          "gimp"
          "git-credential-manager"
          "github"
          "go64"
          "godot"
          "handbrake"
          "hashicorp-boundary-desktop"
          # "hyper"
          "iina"
          "inkscape"
          "iterm2"
          "jellyfin-media-player"
          # "joplin"
          # "kdiff3"
          "keycastr"
          # "kitty"
          "kodi"
          "krita"
          # "ksnip"
          # "langgraph-studio"
          # "leader-key"
          # "league-of-legends"
          # "librewolf"
          "lulu"
          "lunasea"
          "maccy"
          "mactex"
          "macwhisper"
          # "maestral"
          "marta"
          "meetingbar"
          "messenger"
          # "microsoft-auto-update"
          # "microsoft-excel"
          # "microsoft-outlook"
          "microsoft-teams"
          # "microsoft-word"
          "minecraft"
          # "monitorcontrol"
          # "multipass"
          "notion"
          # "numi"
          "obs"
          # "only-switch"
          # "onyx"
          # "openemu"
          "orbstack"
          # "orion"
          "pearcleaner"
          "plex"
          # "prismlauncher"
          "raspberry-pi-imager"
          # "raycast"
          # "reminders-menubar"
          "sf-symbols"
          # "signal"
          # "simplex"
          "skype"
          "slack"
          "sloth"
          "sourcetree"
          "spacedrive"
          "spotify"
          "ssh-config-editor"
          # "stats"
          "steam"
          # "swift-shift"
          # "swiftbar"
          # "tabby"
          # "telegram-desktop"
          # "the-battle-for-wesnoth"
          # "the-unarchiver"
          # "thetimemachinemechanic"
          # "thunderbird"
          # "timemachineeditor"
          "tor-browser"
          "transmission"
          # "trex"
          "upscayl"
          "utm"
          "vagrant"
          "vagrant-manager"
          "vagrant-vmware-utility"
          # "viber"
          "virtualbox"
          # "visual-studio-code"
          # "vlc"
          # "vscodium"
          # "warp"
          # "wave"
          # "wechat"
          # "wezterm"
          "whatsapp"
          # "widelands"
          "yattee"
          "zoom"
        ];
        taps = [
          "dotenvx/brew"
          # "esolitos/ipa"
          "espanso/espanso"
          "felixkratz/formulae"
          "hashicorp/tap"
          "homebrew-ffmpeg/ffmpeg"
          # "marsanne/cask"
          "microsoft/git"
          # "minio/stable"
          # "netdcy/flowvision"
          "olets/tap"
          # "pablopunk/brew"
          "ptsochantaris/tap"
        ];
        masApps = {
          # "Actions" = 1586435171;
          # "Aiko" = 1672085276;
          # "Amazing AI" = 1660147028;
          "Amphetamine" = 937984704;
          "CalcService" = 899970159;
          # "Color Picker" = 1545870783;
          # "Command X" = 6448461551;
          # "Copilot" = 1447330651;
          "CrystalFetch" = 6454431289;
          # "CurrentKey Stats" = 1456226992;
          # "Daily" = 6667115472;
          # "Day Progress" = 6450280202;
          "DeArrow" = 6451469297;
          "Dropover" = 1355679052;
          "Emby" = 992180193;
          # "Encrypto" = 935235287;
          "Fasten Health" = 6471036301;
          # "Folder Peek" = 1615988943;
          # "Folder Preview" = 6698876601;
          # "Ghostery Privacy Ad Blocker" = 6504861501;
          # "Gifski" = 1351639930;
          # "Gladys" = 1382386877;
          # "Hand Mirror" = 1502839586;
          # "HEIC Converter" = 1294126402;
          # "Hidden Bar" = 1452453066;
          "Home Assistant" = 1099568401;
          "HP Smart" = 1474276998;
          "Hush" = 1544743900;
          # "Hyperduck" = 6444667067;
          # "Icon Preview" = 6480373509;
          # "Internet Access Policy Viewer" = 1482630322;
          # "Jami" = 1388475331;
          # "JuxtaText" = 6504801865;
          "Kiano" = 1413833786;
          # "LocalSend" = 1661733229;
          # "Lockdown" = 1483255076;
          "Magnet" = 441258766;
          "Menu Bar Calendar" = 1558360383;
          "Microsoft 365" = 1475226241;
          # "Mima" = 1667149683;
          # "My Applications" = 1630766571;
          # "Notenik" = 1465997984;
          "Notion Web Clipper" = 1559269364;
          # "One Thing" = 1604176982;
          # "Ooooo" = 1482773008;
          # "Pandan" = 1569600264;
          # "Pasteboard" = 1499215709;
          # "PayPal Honey" = 1472777122;
          # "PDF Converter" = 6465168879;
          "PDFgear" = 6469021132;
          "Perplexity" = 6714467650;
          # "PhotoStickies" = 447313635;
          # "Plain Text Editor" = 1572202501;
          # "Plash" = 1494023538;
          "Playgrounds" = 1496833156;
          "Prime Video" = 545519333;
          "Pure Paste" = 1611378436;
          # "Randa" = 1589044499;
          "Record Go" = 6474534754;
          "Recordia" = 1529006487;
          "Refined GitHub" = 1519867270;
          "Save to Raindrop.io" = 1549370672;
          # "Second Clock" = 6450279539;
          "Shareful" = 1522267256;
          # "Shortery" = 1594183810;
          "SocialFocus" = 1661093205;
          # "Spaced" = 1666327168;
          # "Speediness" = 1596706466;
          "SponsorBlock" = 1573461917;
          # "Sprinkles-Mod-the-Web" = 1500209074;
          "Surfed" = 1591590700;
          "Today" = 6443714928;
          "UnTrap" = 1637438059;
          # "Userscripts" = 1463298887;
          # "UTC Time" = 1538245904;
          "Velja" = 1607635845;
          # "VPN Unlimited" = 727593140;
          "KeepSolid VPN Unlimited" = 694633015;
          "Wayback Machine" = 1472432422;
          # "Week Number" = 6502579523;
          "Windows App" = 1295203466;
          "WireGuard" = 1451685025;
          "WordService" = 899972312;
          "XMenu" = 419332741;
        };
        onActivation.cleanup = "zap";
        onActivation.upgrade = false;
        onActivation.autoUpdate = false;
        global.autoUpdate = false;
      };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do  # Added '-r' option here
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      # System-wide settings
      networking = {
        computerName = "Osama's MacBook Air";
        hostName = "macbookair";
        dns = [ "1.1.1.1" "1.0.0.1" ];
        knownNetworkServices = [
          "USB 10/100/1000 LAN"
          "Wi-Fi"
          "UniFi Teleport"
          "VPN Unlimited"
        ];
      };

      system.defaults = {
        dock.autohide  = true;
        dock.autohide-delay = 0.0;
        dock.autohide-time-modifier = 0.0;
        dock.expose-animation-duration = 0.0;
        dock.mineffect = "scale";
        dock.minimize-to-application = true;
        dock.orientation = "left";
        dock.show-recents = false;
        dock.showhidden = true;
        dock.wvous-bl-corner = 1;
        dock.wvous-br-corner = 4;
        dock.wvous-tl-corner = 1;
        dock.wvous-tr-corner = 1;
        dock.persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/LaunchPadder.app"
          "/Applications/Perplexity.app"
          "/Applications/16x Prompt.app"
          "/Applications/ChatGPT.app"
          "/Applications/Claude.app"
          "/Applications/iTerm.app"
          "/Applications/Cursor.app"
          "/Applications/GitButler.app"
          "/Applications/DEVONthink.app"
          "/Applications/Elephas.app"
          "/Applications/Notion.app"
          "/Applications/Safari.app"
          "/Applications/Zen.app"
          "/Applications/VMware Fusion.app"
          "/System/Applications/FaceTime.app"
          "/Applications/Discord.app"
          "/Applications/Messenger.app"
          "/System/Applications/Messages.app"
          "/Applications/WhatsApp.app"
          "/System/Applications/Mail.app"
          "/Applications/Home Assistant.app"
          "/Applications/Plex.app"
          "/System/Applications/iPhone Mirroring.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/Music.app"
          "/System/Applications/Photos.app"
          "/System/Applications/App Store.app"
          "/System/Applications/System Settings.app"
        ];
        finder.AppleShowAllExtensions = true;
        finder.AppleShowAllFiles = true;
        finder.CreateDesktop = false;
        finder.FXDefaultSearchScope = "SCcf";
        finder.FXPreferredViewStyle = "Nlsv";
        finder.NewWindowTarget = "Home";
        finder.ShowExternalHardDrivesOnDesktop = false;
        finder.ShowHardDrivesOnDesktop = false;
        finder.ShowMountedServersOnDesktop = false;
        finder.ShowPathbar = true;
        finder.ShowRemovableMediaOnDesktop = false;
        finder.ShowStatusBar = true;
        finder._FXSortFoldersFirst = true;
        finder._FXSortFoldersFirstOnDesktop = true;
        loginwindow.GuestEnabled  = false;
        menuExtraClock.ShowAMPM = true;
        menuExtraClock.ShowDate = 0;
        menuExtraClock.ShowDayOfMonth = true;
        menuExtraClock.ShowDayOfWeek = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
      };
      # Auto upgrade nix package and the daemon service.
      # services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      nix.gc.automatic = true;

      nix.optimise.automatic = true;

      nixpkgs.config.allowUnfree = true;

      programs.direnv.enable = true;

      programs.nix-index.enable = true;

      security.pam.services.sudo_local.touchIdAuth = true;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."macbookair" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "osama";
            autoMigrate = true;
          };
        }
      ];
    };
    tools = {
      nix-update = inputs.nix-update;
      flake-utils-plus = inputs.flake-utils-plus;
      flake-parts = inputs.flake-parts;
      home-manager = inputs.home-manager;
    };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."macbookair".pkgs;
    defaultPackage.aarch64-darwin = self.darwinConfigurations."macbookair".system;
  };
}
