class ParleyDeckCli < Formula
  desc "CLI for Parley Deck multi-agent workflows"
  homepage "https://github.com/feci/parley-deck-cli"
  url "https://github.com/feci/parley-deck-cli/archive/refs/tags/v1.42.0.tar.gz"
  sha256 "f7c066ede84bd4ff8082df215f32bfed118e98eb7b620ba1d41a8e9551e97924"
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
