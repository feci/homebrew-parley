class ParleyDeckCli < Formula
  desc "CLI for Parley Deck multi-agent workflows"
  homepage "https://github.com/feci/parley-deck-cli"
  url "https://github.com/feci/parley-deck-cli/archive/refs/tags/v1.32.0.tar.gz"
  sha256 "76695af7cec8ea470e8721d041b9aacaeef7dd36a8675a5523f29439d3523c8b"
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
