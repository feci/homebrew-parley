class ParleyDeckCli < Formula
  desc "CLI for Parley Deck multi-agent workflows"
  homepage "https://github.com/feci/parley-deck-cli"
  url "https://github.com/feci/parley-deck-cli/archive/refs/tags/v1.31.0.tar.gz"
  sha256 "88361bb24aa7cbfd940cd2412d5cc4da38f88a4619817a876482c45180b70b77"
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
