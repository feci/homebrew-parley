class ParleyDeckSkill < Formula
  desc "Installer for the Parley Deck multi-agent cooperation skill"
  homepage "https://github.com/feci/parley-deck-skill"
  url "https://github.com/feci/parley-deck-skill/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "3528de80bf8db8272ffbe908da476cf13a8368fef00e1880905d04f4440aa568"
  license "Apache-2.0"
  head "https://github.com/feci/parley-deck-skill.git", branch: "main"

  depends_on "node"

  def install
    readme = (buildpath/"README.md").read
    license_text = (buildpath/"LICENSE").read

    libexec.install Dir["*"]
    (libexec/"README.md").write(readme) unless (libexec/"README.md").exist?
    (libexec/"LICENSE").write(license_text) unless (libexec/"LICENSE").exist?
    bin.write_exec_script libexec/"bin/parley-deck-skill.js"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/parley-deck-skill --version")
  end
end
