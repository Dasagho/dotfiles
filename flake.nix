{
  description = "Global Nix configuration with flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = builtins.currentSystem;
      pkgs = import nixpkgs { inherit system; };
    in
    rec {
      packages.${system}.global = pkgs.stdenv.mkDerivation {
        name = "global-packages-and-configs";
        buildInputs = with pkgs; [
          htop
          git
          gcc
          go
          deno
          fish
          tmux
          docker
          bat
          fzf
          lazygit
          fnm
          kitty
          chromium
          discord
          thunderbird
          visual-studio-code
          vlc
          spotify
          exa
          oh-my-fish
          tpm
        ];

        # Fases vacías ya que no estamos compilando código
        src = null;
        buildPhase = "";
        installPhase = ''
          mkdir -p $out

          # Copiar archivos de configuración al directorio de salida
          mkdir -p $out/etc
          cp -r ${./config/git/gitconfig} $out/etc/gitconfig

          mkdir -p $out/etc/fish
          cp -r ${./config/fish/*} $out/etc/fish/

          mkdir -p $out/etc/xdg/nvim
          cp -r ${./config/nvim/*} $out/etc/xdg/nvim/

          # Copiar fuentes
          mkdir -p $out/usr/share/fonts
          cp -r ${./fonts/*} $out/usr/share/fonts/

          # Otros archivos de configuración
          # Agrega más copias según sea necesario
        '';

        # Establecer las variables de entorno necesarias
        meta = with pkgs.stdenv.lib; {
          description = "Global packages and configurations";
          homepage = "https://your-repo-url";
          license = licenses.mit;
        };
      };
    };
}
