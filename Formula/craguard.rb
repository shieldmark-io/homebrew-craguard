# typed: false
# frozen_string_literal: true

class Craguard < Formula
  desc "EU Cyber Resilience Act compliance scanner for embedded firmware"
  homepage "https://shieldmark.io"
  license "BSL-1.1"
  version "0.5.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.5.2/craguard-0.5.2-darwin-arm64.tar.gz"
      sha256 "f5b60e0d6dbcd1c7ebaaf0ec597440e1ed0108c7bacf29778799fe62dc6c172f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.5.2/craguard-0.5.2-darwin-x64.tar.gz"
      sha256 "6f246fac98afb672b1703f88a46394e96c10ee331157f44bd15e1d4791101088"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.5.2/craguard-0.5.2-linux-arm64.tar.gz"
      sha256 "b6341a8f69f7089d5785625ca0bc19b1d5c4a4fbee47a7a56a806c7c44e1db78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shieldmark-io/craguard/releases/download/v0.5.2/craguard-0.5.2-linux-x64.tar.gz"
      sha256 "2be62e59da95978e877e0cefbdedf23dfbc4dbb1e07f0ce706302f25f940090b"
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
