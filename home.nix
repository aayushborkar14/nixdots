{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "aayush";
    homeDirectory = "/home/aayush";

    stateVersion = "25.11";
  };
}
