class Otag < Formula
  desc "Coordinate AI coding agents (Claude Code, Codex, OpenCode) through tmux"
  homepage "https://github.com/nesiler/otag"
  url "https://github.com/nesiler/otag/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "37d221e6170570abd2173ce6f86c22ac05e72d8ba141ee1f22369b5290ca5c0b"
  license "MIT"
  head "https://github.com/nesiler/otag.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos
  depends_on "tmux"

  def install
    # std_go_args already adds -s -w.
    ldflags = %W[
      -X main.version=#{version}
      -X main.commit=17bac9cf1f4472d976ef2f5c4fc2e866f286fb4a
      -X main.date=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/otag"
  end

  def caveats
    <<~EOS
      Run `otag` to get started: a short wizard sets up your agents and a project,
      and can install the background daemon (launchd; `otag daemon install`).
    EOS
  end

  test do
    assert_match "otag #{version}", shell_output("#{bin}/otag --version")
  end
end
