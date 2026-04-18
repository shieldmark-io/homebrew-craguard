# typed: false
# frozen_string_literal: true

class Craguard < Formula
  desc "EU Cyber Resilience Act security assessment scanner for embedded firmware"
  homepage "https://shieldmark.io"
  license "BSL-1.1"
  version "0.6.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shieldmark-io/homebrew-craguard/releases/download/v0.6.6/craguard-0.6.6-darwin-arm64.tar.gz"
      sha256 "60bfc462535b3e12cbd257df7bf069c9ef5cdf03532b858d00e74338207a2446"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shieldmark-io/homebrew-craguard/releases/download/v0.6.6/craguard-0.6.6-darwin-x64.tar.gz"
      sha256 "d99b2babca499cf03219b08a707ba5c8b41a442e798c6b4dbc3e88ef7549a980"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shieldmark-io/homebrew-craguard/releases/download/v0.6.6/craguard-0.6.6-linux-arm64.tar.gz"
      sha256 "637e6deb74aac502ab518f4fd4ad671591b48ff8451d354c51bb4aa21804b28a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shieldmark-io/homebrew-craguard/releases/download/v0.6.6/craguard-0.6.6-linux-x64.tar.gz"
      sha256 "d7e237e00234a685fbf8469877945873a51ef3040636613f6ba95f44b75a9350"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"craguard"
  end

  def caveats
    <<~EOS
      Quick start:
        craguard scan ./your-firmware-project
        craguard --help
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/craguard --version")
  end
end
