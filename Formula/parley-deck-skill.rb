class ParleyDeckSkill < Formula
  desc "Installer for the Parley Deck multi-agent cooperation skill"
  homepage "https://github.com/feci/parley-deck-skill"
  url "https://github.com/feci/parley-deck-skill/archive/refs/tags/v2.6.0.tar.gz"
  sha256 "37934effd8a06c28dedb77447785b0e62cfe561b9f13711961c68b4ba713a80f"
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
  # content this formula must ship verbatim, so the rewrite is undone here — post_install runs
  # after the rewrite, and only a shebang pointing into a Homebrew prefix is touched.
  def post_install
    Dir.glob("#{libexec}/skills/**/*").each do |file|
      next unless File.file?(file)

      body = File.read(file)
      next unless body.start_with?("#!")

      shebang = body.lines.first
      next unless shebang =~ %r{\A#!\s*(/opt/homebrew|/usr/local|#{Regexp.escape(HOMEBREW_PREFIX.to_s)})\S*/([^/\s]+)}

      File.write(file, body.sub(/\A#![^\n]*\n/, "#!/usr/bin/env #{Regexp.last_match(2)}\n"))
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/parley-deck-skill --version")

    # The release that broke this shipped a CLI that could not install anything. A version
    # string is not evidence that it works.
    ENV["HOME"] = testpath
    system bin/"parley-deck-skill", "install", "--target", "codex", "--yes"
    assert_predicate testpath/".codex/skills/parley-deck/SKILL.md", :exist?
    system bin/"parley-deck-skill", "doctor", "--target", "codex"
  end
end
