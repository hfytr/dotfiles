{ stdenv, fetchFromGitHub }:
{
  sddm-sugar-candy-theme = stdenv.mkDerivation rec {
    pname = "sddm-sugar-candy-theme";
    version = "1.6";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-candy
    '';
    src = ./sddm-sugar-candy;
  };
}
