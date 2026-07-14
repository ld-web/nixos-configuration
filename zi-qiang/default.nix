{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "zi-qiang";
  version = "unstable-2026-07-14";

  src = fetchFromGitHub {
    owner = "ld-web";
    repo = "zi-qiang";
    rev = "1fa27a4017b8910f6e934f68c1ff42a1a501244a";
    hash = "sha256-asKoL5LpyywqJIjR3RoAabkdvelybBwrEU5xup9SAXw=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postInstall = ''
    ln -s zh_wallpaper $out/bin/zi-qiang
  '';

  meta = {
    description = "Chinese words wallpaper rotation";
    homepage = "https://github.com/ld-web/zi-qiang";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
    mainProgram = "zi-qiang";
  };
}
