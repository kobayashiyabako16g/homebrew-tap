class DppCli < Formula
  desc "CLI tool for managing dpp.vim plugins."
  homepage "https://github.com/kobayashiyabako16g/dpp-cli"
  version "1.0.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.3/dpp-cli-macos-aarch64.tar.gz"
      sha256 "61cb7527a3e9489e4289ff1cb0f1e985c6655c5cb6f0d2be383f33e6db536acb"
    else
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.3/dpp-cli-macos-x86_64.tar.gz"
      sha256 "7642a31de29cfe5439245f29a905c22930c9b12f0b25006f2eb4948e7652fc27"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.3/dpp-cli-linux-x86_64.tar.gz"
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