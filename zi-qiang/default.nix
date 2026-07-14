{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zi-qiang";
  version = "0-unstable-2026-07-14";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "ld-web";
    repo = "zi-qiang";
    rev = "2ec793f505d5f4119018debad3731a28ba9c7943";
    hash = "sha256-zHMw8t5S71MIwXeb9Mn0uTSQ0fieiE0ZPC4FWbA0CRM=";
  };

  cargoHash = "sha256-LDHifOvRPVUF3FkOzXao+0SUCpL3OJa0xKiKUwYjKpY=";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Chinese words wallpaper rotation";
    homepage = "https://github.com/ld-web/zi-qiang";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
    mainProgram = "zi-qiang";
  };
})
