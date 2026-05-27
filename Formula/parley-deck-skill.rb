class ParleyDeckSkill < Formula
  desc "Installer for the Parley Deck multi-agent cooperation skill"
  homepage "https://github.com/feci/parley-deck-skill"
  url "https://github.com/feci/parley-deck-skill/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "c8c0afd689865f34d1acffa5e52c3ef875d43c7eb778c2f6bd890400da09c18d"
  license "Apache-2.0"
  head "https://github.com/feci/parley-deck-skill.git", branch: "main"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/parley-deck-skill.js" => "parley-deck-skill"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/parley-deck-skill --version")
  end
end
