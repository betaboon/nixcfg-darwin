{ config, pkgs, ...}:
{

  home.packages = with pkgs; [
    neofetch
  ];

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "23.11";

}
