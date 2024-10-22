{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
buildInputs = [ 
  typst
  gcc 
  opencv 
  unixtools.xxd 
  rustc 
  cargo
]; # your dependencies here
 nativeBuildInputs = [
      libclang.lib
      llvmPackages.libcxxClang
      clang
      libGL
      libglvnd
  ];
  LIBCLANG_PATH = "${libclang.lib}/lib";
}
