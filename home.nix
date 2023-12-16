{ config, pkgs, ...}:
{

  home.packages = with pkgs; [
    neofetch
  ];

  programs.fish = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      nix-switch = "darwin-rebuild switch --flake ~/.config/nix-darwin";
    };
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";

}
