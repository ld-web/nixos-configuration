{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "dcsrs-to-pdf";
  version = "unstable-2025-02-24";

  src = fetchFromGitHub {
    owner = "ld-web";
    repo = "docusaurus-to-pdf";
    rev = "046b6fcabf0bc35a0aa024b46b2c3fe20e746b41";
    hash = "sha256-vqBejrkFOPZ2FwRdhqmoQNS7eZ7LqWlvKk1R0xzgPuY=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "chromiumoxide-0.7.0" = "sha256-ZRTk5r5WLq9c+rvjqyAnB7pzdFbXl2IQBTg2w77IllY=";
    };
  };

  meta = {
    description = "Rust CLI utility to turn a Docusaurus website into PDF files";
    homepage = "https://github.com/ld-web/docusaurus-to-pdf";
    license = lib.licenses.unfree; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ ];
    mainProgram = "dcsrs-to-pdf";
  };
}
