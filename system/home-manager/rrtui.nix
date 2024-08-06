{ pkgs ? import <nixpkgs> {} }:
  pkgs.rustPlatform.buildRustPackage rec {
    pname = "royal_rust";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
        owner = "hfytr";
        repo = "royal_rust";
        rev = "be1320ccc158105ccc88ccb982eef615a3c8af63";
        hash = "sha256-71ED4giPHofAPqSUimBngQ6HwsVz+LjVBs+dl7BwElU=";
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
