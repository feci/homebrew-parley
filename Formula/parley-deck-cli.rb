class ParleyDeckCli < Formula
  desc "CLI for Parley Deck multi-agent workflows"
  homepage "https://github.com/feci/parley-deck-cli"
  url "https://github.com/feci/parley-deck-cli/archive/refs/tags/v1.30.0.tar.gz"
  sha256 "ed4083b2f6b008191ec9b05347ed2555db9c18d9553a80eb388e42245d029551"
  license "Apache-2.0"
  head "https://github.com/feci/parley-deck-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-ldflags", "-s -w", "-o", bin/"parley", "./cmd/parley"
  end

  test do
    assert_match "parley #{version}", shell_output("#{bin}/parley version")
    assert_match "orchestrates Parley Deck", shell_output("#{bin}/parley help")
  end
end
