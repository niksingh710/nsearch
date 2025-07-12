{
  pkgs ? import <nixpkgs> { },
  lib ? import <nixpkgs/lib>,
}:
pkgs.writeShellApplication {
  name = "nsearch";
  runtimeInputs = with pkgs; [
    jq
    fzf
    bash
  ];
  text = lib.readFile ./src/nsearch;

  meta = with lib; {
    description = "Search for packages in Nixpkgs";
    license = licenses.gpl3;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ niksingh710 ];
    mainProgram = "nsearch";
  };
}
