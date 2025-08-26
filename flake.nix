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
      environment.systemPackages = with pkgs; [
        # apps
        alt-tab-macos
        iina
        # iterm2
        # raycast
        # obsidian
        # postman
        # sublime4
        # vscode

        # vscode
        # vscode-extensions.redhat.java

        # dev tools
        neovim
        direnv
        awscli2
        lazydocker
        lazygit
        libpq
        ripgrep
        git-credential-manager
        
        # containers
        colima
        docker

        # utils
        ffmpeg
        fzf
        gh
        git
        hurl
        jq

        # java
        corretto21
        gradle

        # go
        go

        # devops
        apacheKafka
        kubectx
        kubernetes-helm
        repomix
        stern
        terraform
        temporal-cli

        # nodejs
        nodejs

        # python
        python3
        uv

        # shell
        watch
        zsh-autosuggestions
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      nix.enable = false; # Necessary for using Determinate nix

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#P43KXLFVNF
    darwinConfigurations."P43KXLFVNF" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
