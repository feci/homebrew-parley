class ParleyDeckSkill < Formula
  desc "Installer for the Parley Deck multi-agent cooperation skill"
  homepage "https://github.com/feci/parley-deck-skill"
  url "https://github.com/feci/parley-deck-skill/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "4816eab26dcd7adaad0205861fe35b9638d7b4a27151616bdc049eb565147204"
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
