class CcLimits < Formula
  desc "Claude Code and Codex usage limits in the macOS menu bar"
  homepage "https://cc-limits.morox.ai"
  url "https://github.com/morox-ai/cc-limits/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "6a57576e94076607966fe1035ac213d29b569cd448ca0059b3d877abcf862221"
  license "MIT"
  head "https://github.com/morox-ai/cc-limits.git", branch: "main"

  depends_on macos: :monterey

  def install
    system "bash", "build.sh"
    libexec.install "CCLimits.app", "cc-limits"
    bin.install_symlink libexec/"cc-limits"
  end

  service do
    run [opt_libexec/"CCLimits.app/Contents/MacOS/CCLimits"]
    keep_alive successful_exit: false
    process_type :interactive
  end

  test do
    assert_match "Usage: cc-limits", shell_output("#{bin}/cc-limits --help")
    assert_predicate libexec/"CCLimits.app/Contents/MacOS/CCLimits", :executable?
  end
end
