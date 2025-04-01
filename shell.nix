{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
buildInputs = [ 
  texliveFull
]; # your dependencies here
}
