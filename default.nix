{ pkgs ? import <nixpkgs> { }, lib, jq, fzf, }:
pkgs.writeShellApplication {
  name = "nsearch";
  runtimeInputs = [ jq fzf ];
  text = lib.readFile ./nsearch;

  meta = with lib; {
    description = "Search for packages in Nixpkgs";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ niksingh710 ];
    mainProgram = "nsearch";
  };
}
