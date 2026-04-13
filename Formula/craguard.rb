# typed: false
# frozen_string_literal: true

# Custom download strategy for private GitHub repository release assets.
# Requires HOMEBREW_GITHUB_API_TOKEN to be set.
require "download_strategy"

class GitHubPrivateReleaseDownloadStrategy < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    unless token
      raise <<~EOS
        HOMEBREW_GITHUB_API_TOKEN is required to install CRAGuard from a private repository.

        Set it with:
          export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)
        or:
          export HOMEBREW_GITHUB_API_TOKEN=ghp_your_personal_access_token
      EOS
    end

    curl_download(
      resolved_url || url,
      "--header", "Authorization: token #{token}",
      "--header", "Accept: application/octet-stream",
      "--location",
      to: temporary_path,
      timeout: timeout,
    )
  end
end

class Craguard < Formula
  desc "EU Cyber Resilience Act security assessment scanner for embedded firmware"
  homepage "https://shieldmark.io"
  license "BSL-1.1"
  version "0.6.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/shieldmark-io/craguard/releases/assets/395299671",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "37d7ecef5b2160f5ff2bf12c26d1cfbc20b30ce0ea485a453ac61907a4ffdc7c"
    end
    if Hardware::CPU.intel?
      url "https://api.github.com/repos/shieldmark-io/craguard/releases/assets/395299669",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "1dd39d3291d1f122ad72295fa3361a879a7da56588d94a96aa92e456d800070a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/shieldmark-io/craguard/releases/assets/395299673",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "5cae1dc3e4ab4393e1766711a88c09a5aa5a36d370fd4d9534f6bf312a9b5385"
    end
    if Hardware::CPU.intel?
      url "https://api.github.com/repos/shieldmark-io/craguard/releases/assets/395299668",
          using: GitHubPrivateReleaseDownloadStrategy
      sha256 "dfc8b7207e84741c86102f40fd58a69a1d2d6be4bde6a4967eb249af3e6afd31"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"craguard"
  end

  def caveats
    <<~EOS
      CRAGuard requires HOMEBREW_GITHUB_API_TOKEN for updates:
        export HOMEBREW_GITHUB_API_TOKEN=$(gh auth token)

      Quick start:
        craguard scan ./your-firmware-project
        craguard --help
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/craguard --version")
  end
end
