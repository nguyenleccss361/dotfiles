{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "nguyenlh6";
    homeDirectory = "/home/nguyenlh6";
    stateVersion = "24.11";
  };

  home.packages = with pkgs; [
    # dev
    neovim
    zsh
    gh

    # utils
    # kanata
    fastfetch
    fzf
    jq
    ripgrep
    tree
    btop
    feh
    playerctl
    xclip
    zoxide
    xdotool
    bat
    delta
    i3-resurrect
    dnsutils
    inetutils
    autokey
    warpd
    keynav
    espanso

    # font
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file = {
    ".config/home-manager".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager";
    ".config/nix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nix";
    ".config/kanata/brick-hrm.kbd".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kanata/brick-hrm.kbd";
    ".config/systemd/user/kanata-brick.service".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kanata/kanata-brick.service";
    ".config/kanata/sofle-v1.kbd".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kanata/sofle-v1.kbd";
    ".config/systemd/user/kanata-sofle-v1.service".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kanata/kanata-sofle-v1.service";
    ".config/i3".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/i3";
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/alacritty";
    ".config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/rofi";
    ".config/mouseless/config.yaml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/mouseless/config.yaml";
    ".keynavrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/mouseless/keynavrc";
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/git/gitconfig";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zsh/zshrc";
    ".p10k.zsh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zsh/p10k.zsh";
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/tmux/tmux.conf";
    ".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/vim/vimrc";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
