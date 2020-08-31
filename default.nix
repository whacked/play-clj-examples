let
  pkgs = import <nixpkgs> {};
  stdenv = pkgs.stdenv;
in stdenv.mkDerivation rec {
  name = "play-clj-examples";
  env = pkgs.buildEnv {
    name = name;
    paths = buildInputs;
  };
  buildInputs = [
    pkgs.xorg.libXxf86vm
    pkgs.openal
  ];

  shellHook = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.xorg.libXxf86vm}/lib:${pkgs.openal}/lib
    function run() {
      project=$1
      pushd $project/desktop
      nixGL lein run
      popd
    }
  '';
}
