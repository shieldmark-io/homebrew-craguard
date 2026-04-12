# typed: false
# frozen_string_literal: true

class Craguard < Formula
  desc "EU Cyber Resilience Act compliance scanner for embedded firmware"
  homepage "https://shieldmark.io"
  license "BSL-1.1"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.6.0/craguard-0.6.0-darwin-arm64.tar.gz"
      sha256 "36d54182cc443668f9427edf1df038f251e157e7975ee1651e5282731d32b235"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.6.0/craguard-0.6.0-darwin-x64.tar.gz"
      sha256 "c1fbdfe9b4ba5f629de6c866e931221e5e5e2c167240ad95bfc45fd10db93580"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.6.0/craguard-0.6.0-linux-arm64.tar.gz"
      sha256 "f403bb55ea6f6025f63b42dba6b3f9c202ca3570098c7b14fa5dde86619d02bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.6.0/craguard-0.6.0-linux-x64.tar.gz"
      sha256 "a671f573245075d61fb7d9087b670a6428b873f124b9131035bd6ebd145ccf15"
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
