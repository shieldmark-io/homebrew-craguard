# typed: false
# frozen_string_literal: true

class Craguard < Formula
  desc "EU Cyber Resilience Act compliance scanner for embedded firmware"
  homepage "https://shieldmark.io"
  license "BSL-1.1"
  version "0.6.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.6.5/craguard-0.6.5-darwin-arm64.tar.gz"
      sha256 "37d7ecef5b2160f5ff2bf12c26d1cfbc20b30ce0ea485a453ac61907a4ffdc7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.6.5/craguard-0.6.5-darwin-x64.tar.gz"
      sha256 "1dd39d3291d1f122ad72295fa3361a879a7da56588d94a96aa92e456d800070a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.6.5/craguard-0.6.5-linux-arm64.tar.gz"
      sha256 "5cae1dc3e4ab4393e1766711a88c09a5aa5a36d370fd4d9534f6bf312a9b5385"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.6.5/craguard-0.6.5-linux-x64.tar.gz"
      sha256 "dfc8b7207e84741c86102f40fd58a69a1d2d6be4bde6a4967eb249af3e6afd31"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"craguard"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/craguard --version")
  end
end
