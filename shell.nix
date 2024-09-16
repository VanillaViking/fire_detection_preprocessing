{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
buildInputs = [ unixtools.xxd cargo rustc ]; # your dependencies here
}
