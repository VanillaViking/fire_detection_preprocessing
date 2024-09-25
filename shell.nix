{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
buildInputs = [ unixtools.xxd cargo rustc typst ]; # your dependencies here
}
