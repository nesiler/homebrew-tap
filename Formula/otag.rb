class Otag < Formula
  desc "Coordinate AI coding agents (Claude Code, Codex, OpenCode) through tmux"
  homepage "https://github.com/nesiler/otag"
  url "https://github.com/nesiler/otag/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "d58e676c55fe42e28a2406d1dfb7fb72f4a68a9239e6caf8218e2f81eb09fea1"
  license "MIT"
  head "https://github.com/nesiler/otag.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos
  depends_on "tmux"

  def install
    # std_go_args already adds -s -w.
    ldflags = %W[
      -X main.version=#{version}
      -X main.commit=bdf9ba3eebe996ec4762aa95bce8934465a161f5
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
