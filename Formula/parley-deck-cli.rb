class ParleyDeckCli < Formula
  desc "CLI for Parley Deck multi-agent workflows"
  homepage "https://github.com/feci/parley-deck-cli"
  url "https://github.com/feci/parley-deck-cli/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "f82f751fdb0473a975d21450711f25871f3c447b888df051c6ead8ca31e24b83"
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
