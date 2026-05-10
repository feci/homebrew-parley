class ParleyDeckSkill < Formula
  desc "Installer for the Parley Deck multi-agent cooperation skill"
  homepage "https://github.com/feci/parley-deck-skill"
  url "https://github.com/feci/parley-deck-skill/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "765de96780b8758eede454734e05179fccda0cf3bc2bbe5b1252ddd4832c14b9"
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
