class ParleyDeckSkill < Formula
  desc "Installer for the Parley Deck multi-agent cooperation skill"
  homepage "https://github.com/feci/parley-deck-skill"
  url "https://github.com/feci/parley-deck-skill/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "6eefe999780aadbf11f050f883ab1b08846cef93720b95a566ebc181778bf718"
  license "Apache-2.0"
  head "https://github.com/feci/parley-deck-skill.git", branch: "main"

  depends_on "node"

  # Homebrew's cleaner rewrites `#!/usr/bin/env node` to an absolute interpreter path in every
  # script it installs. From 2.2.0 each packaged skill ships a `parley-addon.json` integrity
  # manifest covering its own files byte for byte, so that rewrite makes the payload disagree
  # with its manifest and the installer refuses to install anything at all:
  #
  #   failed parley-tracker - Source payload does not match parley-addon.json:
  #                           modified: bin/claim.js; modified: bin/validate.js
  #
  # The payload is inert instruction and script content that this formula must ship verbatim.
  skip_clean libexec/"skills"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/parley-deck-skill.js" => "parley-deck-skill"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/parley-deck-skill --version")
  end
end
