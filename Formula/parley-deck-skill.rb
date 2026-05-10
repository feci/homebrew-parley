class ParleyDeckSkill < Formula
  desc "Installer for the Parley Deck multi-agent cooperation skill"
  homepage "https://github.com/feci/parley-deck-skill"
  url "https://github.com/feci/parley-deck-skill/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "80e7a3bd39c93cb57fc653bfcf281edec60b571393fe8067be6c54d32d58ae3c"
  license "Apache-2.0"
  revision 1
  head "https://github.com/feci/parley-deck-skill.git", branch: "main"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    (libexec/"README.md").write((buildpath/"README.md").read)
    (libexec/"LICENSE").write((buildpath/"LICENSE").read)
    bin.write_exec_script libexec/"bin/parley-deck-skill.js"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/parley-deck-skill --version")
  end
end
