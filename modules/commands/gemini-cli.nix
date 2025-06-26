{ lib, buildNpmPackage, fetchFromGitHub, nix-update-script, }: let
  pname = "gemini-cli";
  version = "0.1.1";
in buildNpmPackage {
  inherit pname version;
  src = fetchFromGitHub {
    owner = "google-gemini";
    repo = "gemini-cli";
    rev = "21cfe9f6801f286dda6d51d2886e27bd67bd5fa4";
    hash = "sha256-Dlh1B1+rGVwA+JjLLjNppa/4Ms7FXMHQW3SY9JIRlcs=";
  };
  npmDepsHash = "sha256-2zyMrVykKtN+1ePQko9MVhm79p7Xbo9q0+r/P22buQA=";
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
