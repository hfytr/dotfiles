{ pkgs ? import <nixpkgs> {} }:
  pkgs.rustPlatform.buildRustPackage rec {
    pname = "royal_rust";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
        owner = "hfytr";
        repo = "royal_rust";
        rev = "db728e6a183b355ac51d8a00a5eff1b57e77dbe4";
        hash = "sha256-GeraaKoZopHxj9OlqPzp3fYOPbKYKb9h/Is4a297vSM=";
    };

    cargoHash = "sha256-OmUryz5MCxHCIMDtGPhTPmNUUOLEM0v49J4rX2UdlYg=";

    nativeBuildInputs = [
      pkgs.openssl
      pkgs.pkg-config
      pkgs.perl
    ];
  
    buildInputs = [
      pkgs.openssl
    ];
  
    cargoBuildOptions = [
      "--release"
    ];
  
    buildPhase = ''
      export OPENSSL_DIR=${pkgs.openssl.dev}
      export PKG_CONFIG_ALLOW_CROSS=1
      cargo build --release
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp target/release/rrtui $out/bin/
    '';

    meta = with pkgs.lib; {
      description = "A read-only TUI for royalroad, with a corrisponding API";
      homepage = "https://github.com/hfytr/royal_rust";
      license = licenses.unlicense;
      maintainers = with maintainers; [ "hfytr" ];
      platforms = platforms.linux;
    };
  }
