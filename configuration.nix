{ pkgs, ... }: {

  users.users.betaboon = {
    home = "/Users/betaboon";
    shell = pkgs.fish;
  };

  home-manager.users.betaboon = import ./home.nix;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;
}
