{ pkgs ? import <nixpkgs> { } }:
let inherit (pkgs) lib;
in pkgs.stdenv.mkDerivation {
  name = "nsearch";
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp $src/nsearch $out/bin/nsearch
  '';

  meta = with lib; {
    description = "Search for packages in Nixpkgs";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ niksingh710 ];
    mainProgram = "nsearch";
  };
}
