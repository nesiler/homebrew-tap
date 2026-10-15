class Otag < Formula
  desc "Coordinate AI coding agents (Claude Code, Codex, OpenCode) through tmux"
  homepage "https://github.com/nesiler/otag"
  url "https://github.com/nesiler/otag/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0279fcfc095c24401a99a84aabd304869b95774c8fb3222fc03806e7a093f64f"
  license "MIT"
  head "https://github.com/nesiler/otag.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos
  depends_on "tmux"

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=21099aa1fdc56717f2564b7e5aa8ce823920d858
      -X main.date=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/otag"
  end

  def caveats
    <<~EOS
      Start the background daemon (launchd) and check your setup:
        otag daemon install
        otag doctor
    EOS
  end

  test do
    assert_match "otag #{version}", shell_output("#{bin}/otag --version")
  end
end
