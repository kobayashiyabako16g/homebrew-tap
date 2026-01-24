class DppCli < Formula
  desc "CLI tool for managing dpp.vim plugins."
  homepage "https://github.com/kobayashiyabako16g/dpp-cli"
  version "1.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.2/dpp-cli-macos-aarch64.tar.gz"
      sha256 "20ec65aaa07997d779ceea706d12965c6aeeda25ee125c56d2ab96567893d23c"
    else
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.2/dpp-cli-macos-x86_64.tar.gz"
      sha256 "d334e0de7461915974f6b1c5379cf2c6dc4e3c7e27ba1b7ee47077a92c51a8a8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.2/dpp-cli-linux-x86_64.tar.gz"
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