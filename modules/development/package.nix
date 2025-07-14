{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "unpack-to-etc";
  version = "0";

  src = fetchFromGitHub {
    owner = "piuccio";
    repo = "cowsay";
    rev = "eef317a302d025e3f31787566727c49eaee43648";
    hash = "";
  };

  # No build phase needed for config files
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    # Create the target directory
    mkdir -p $out/etc/calamares

    # Copy all files from the source to /etc/calamares
    cp -r $src/* $out/etc/calamares/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Unpack cowsay to etc to test";
    homepage = "https://github.com/Alloy-Linux";
    license = licenses.gpl3;
    maintainers = [ maintainers.miyu ];
    platforms = platforms.linux;
  };
}
