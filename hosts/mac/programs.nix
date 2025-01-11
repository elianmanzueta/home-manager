{ pkgs, ... }:

{
  users.users.elian = {
    name = "elian";
    home = "/Users/elian";
  };

  environment = {
    systemPackages = with pkgs; [ neovim git ];
  };

  homebrew = {
    enable = true;

    onActivation = { autoUpdate = false; };

    taps = [ "homebrew/services" ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [ "fish" ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [ "vivaldi" "proton-mail" "proton-pass"  "wezterm" "anki" ];
  };

}
