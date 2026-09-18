class ParleyDeckSkill < Formula
  desc "Installer for the Parley Deck multi-agent cooperation skill"
  homepage "https://github.com/feci/parley-deck-skill"
  url "https://github.com/feci/parley-deck-skill/archive/refs/tags/v2.12.1.tar.gz"
  sha256 "9e019d7d52f89bd4de7fedb9a0c610273699e4177d7fb53da6fcd343c658408f"
  license "Apache-2.0"
  head "https://github.com/feci/parley-deck-skill.git", branch: "main"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/parley-deck-skill.js" => "parley-deck-skill"
  end

  # Homebrew rewrites `#!/usr/bin/env node` to an absolute interpreter path inside its own
  # prefix. From 2.2.0 every packaged skill ships a `parley-addon.json` covering its own files
  # byte for byte, so that rewrite makes the payload disagree with its manifest and the
  # installer refuses to install ANY skill:
  #
  #   failed parley-tracker - Source payload does not match parley-addon.json:
  #                           modified: bin/claim.js; modified: bin/validate.js
  #
  # `skip_clean` does not prevent it (tried in all three documented forms). The payload is inert
  # content this formula must ship verbatim, so the rewrite is undone here — post_install_steps runs
  # after the rewrite, and only a shebang pointing into a Homebrew prefix is touched.
  post_install_steps do
    run "opt/node/bin/node", base: :homebrew_prefix,
                             args: ["-e", <<~JS, "{{libexec}}/skills", "{{HOMEBREW_PREFIX}}"]
                               const fs = require("node:fs");
                               const path = require("node:path");
                               const prefixes = ["/opt/homebrew", "/usr/local", process.argv[2]];
                               function restore(dir) {
                                 for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
                                   const file = path.join(dir, entry.name);
                                   if (entry.isDirectory()) { restore(file); continue; }
                                   if (!entry.isFile()) continue;
                                   const body = fs.readFileSync(file, "utf8");
                                   const match = body.match(/^#![ \\t]*(\\S+)[ \\t]*\\n/);
                                   if (!match || !prefixes.some(prefix => match[1].startsWith(prefix + "/"))) continue;
                                   const interpreter = path.basename(match[1]);
                                   fs.writeFileSync(file, "#!/usr/bin/env " + interpreter + "\\n" + body.slice(match[0].length));
                                 }
                               }
                               restore(process.argv[1]);
                             JS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/parley-deck-skill --version")

    # The release that broke this shipped a CLI that could not install anything. A version
    # string is not evidence that it works.
    ENV["HOME"] = testpath
    system bin/"parley-deck-skill", "install", "--target", "codex", "--yes"
    assert_path_exists testpath/".codex/skills/parley-deck/SKILL.md"
    system bin/"parley-deck-skill", "doctor", "--target", "codex"
  end
end
