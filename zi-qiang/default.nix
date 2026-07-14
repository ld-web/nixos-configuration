{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
  makeWrapper,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zi-qiang";
  version = "0-unstable-2026-07-14";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "ld-web";
    repo = "zi-qiang";
    rev = "3a6ae188bdbe957eca39e2da329be505a6f443cc";
    hash = "sha256-IaeBAIJLBSZeXLe0OpATMYA2xAinepYB0BySHxccB28=";
  };

  cargoHash = "sha256-LDHifOvRPVUF3FkOzXao+0SUCpL3OJa0xKiKUwYjKpY=";

  passthru.updateScript = nix-update-script { };

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    mkdir -p $out/share/zi-qiang
    cp $src/data/zh_chars.json $out/share/zi-qiang/

    wrapProgram $out/bin/zi_qiang \
      --add-flags "--input $out/share/zi-qiang/zh_chars.json --output ~/.cache/zi-qiang/wallpaper.png"

    ln -s zi_qiang $out/bin/zi-qiang
  '';

  meta = {
    description = "Chinese words wallpaper rotation";
    homepage = "https://github.com/ld-web/zi-qiang";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
    mainProgram = "zi-qiang";
  };
})
