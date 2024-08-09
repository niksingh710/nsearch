{ pkgs ? import <nixpkgs> { }, jq, fzf, makeWrapper, }:

let inherit (pkgs) lib;
in pkgs.stdenv.mkDerivation {
  name = "nsearch";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/nsearch $out/bin/nsearch
  '';

  postInstall = ''
    wrapProgram $out/bin/nsearch --prefix PATH ':' \
      "${lib.makeBinPath [ jq fzf ]}"
  '';

  meta = with lib; {
    description = "Search for packages in Nixpkgs";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ niksingh710 ];
    mainProgram = "nsearch";
  };
}
