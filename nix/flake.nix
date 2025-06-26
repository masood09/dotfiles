{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      documentation.enable = false;

      environment.systemPackages = [
        # System Utils
        pkgs.bat
        pkgs.btop
        pkgs.coreutils
        pkgs.coreutils-prefixed
        pkgs.fzf
        pkgs.git
        pkgs.neofetch

        # Terminal Programs
        pkgs.age
        pkgs.ansible
        pkgs.k9s
        pkgs.kubectl
        pkgs.kubernetes-helm
        pkgs.neovim
        pkgs.opentofu
        pkgs.packer
        pkgs.sops
        pkgs.stow
        pkgs.talosctl
        pkgs.tmux

        # GUI Programs
        pkgs.brave
        pkgs.discord
        pkgs.wezterm
      ];

      environment.shells = [
        pkgs.bash
        pkgs.fish
        pkgs.zsh
      ];

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.nerd-fonts.meslo-lg
      ];

      homebrew = {
        enable = true;

        onActivation = {
          cleanup = "zap";
          autoUpdate = true;
          upgrade = true;
        };
          
        global.autoUpdate = true;
          
        casks = [
          "alfred"
          "appcleaner"
          "balenaetcher"
          "opencloud"
          "waterfox"
        ];

        masApps = {
          "Bitwarden Desktop" = 1352778147;
          "Caffeinated" = 1362171212;
          "Home Assistant" = 1099568401;
          "Infuse" = 1136220934;
          "Unarchiver" = 425424353;
          "Windows App" = 1295203466;
        };
      };

      system.primaryUser = "masoodahmed";

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      nixpkgs.config.allowUnfree = true;

      security.pam.services.sudo_local = {
        enable = true;
        touchIdAuth = true;
        reattach = true;
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#murderbot
    darwinConfigurations."murderbot" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
