class DppCli < Formula
  desc "CLI tool for managing dpp.vim plugins."
  homepage "https://github.com/kobayashiyabako16g/dpp-cli"
  version "1.0.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.4/dpp-cli-macos-aarch64.tar.gz"
      sha256 "902eeaa43964598180442b789d3f4158f55b73af8046cdd943c161576e315ed7"
    else
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.4/dpp-cli-macos-x86_64.tar.gz"
      sha256 "ca3c1f40a1bea643095683be242b1bfd005042a1a9b8b2dfe5779c925c4b234b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.4/dpp-cli-linux-x86_64.tar.gz"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "dpp-cli-macos-aarch64" => "dpp-cli"
      else
        bin.install "dpp-cli-macos-x86_64" => "dpp-cli"
      end
    elsif OS.linux?
      bin.install "dpp-cli-linux-x86_64" => "dpp-cli"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dpp-cli --version")
  end

  def caveats
    <<~EOS
      dpp-cli requires Neovim or Vim to run.
      You can install Neovim via Homebrew:
        brew install neovim

      Or Vim:
        brew install vim

      To get started with dpp.vim:
        dpp-cli init -t scaffold -e nvim

      For more information, visit:
        https://github.com/kobayashiyabako16g/dpp-cli
    EOS
  end
end