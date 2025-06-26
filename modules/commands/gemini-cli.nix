{ lib, buildNpmPackage, fetchFromGitHub, nix-update-script, }: let
  pname = "gemini-cli";
  version = "0.1.5";
in buildNpmPackage {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "google-gemini";
    repo = "gemini-cli";
    rev = "121bba346411cce23e350b833dc5857ea2239f2f";
    hash = "sha256-2w28N6Fhm6k3wdTYtKH4uLPBIOdELd/aRFDs8UMWMmU=";
  };
  npmDepsHash = "sha256-yoUAOo8OwUWG0gyI5AdwfRFzSZvSCd3HYzzpJRvdbiM=";
  fixupPhase = ''
    runHook preFixup
    find $out -type l -exec test ! -e {} \; -delete 2>/dev/null || true
    mkdir -p "$out/bin"
    ln -sf "$out/lib/node_modules/@google/gemini-cli/bundle/gemini.js" "$out/bin/gemini"
    patchShebangs "$out/bin" "$out/lib/node_modules/@google/gemini-cli/bundle/"
    runHook postFixup
  '';
  passthru.updateScript = nix-update-script { };
  meta.description = "AI agent that brings the power of Gemini directly into your terminal";
  meta.homepage = "https://github.com/google-gemini/gemini-cli";
  meta.license = lib.licenses.asl20;
  meta.maintainers = with lib.maintainers; [ donteatoreo ];
  meta.platforms = lib.platforms.all;
  meta.mainProgram = "gemini";
}
