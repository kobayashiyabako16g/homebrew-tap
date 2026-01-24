class DppCli < Formula
  desc "CLI tool for managing dpp.vim plugins."
  homepage "https://github.com/kobayashiyabako16g/dpp-cli"
  version "1.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.2/dpp-cli-macos-aarch64.tar.gz"
      sha256 "62b682487f013b6d5c428fa38e96ab1885d453832c4ce3f2b19cb983564f266a"
    else
      url "https://github.com/kobayashiyabako16g/dpp-cli/releases/download/v1.0.2/dpp-cli-macos-x86_64.tar.gz"
      sha256 "78d4d030d822c07d49a863e4391de0c21ac31e79e923e47de0e8db93a6aadfbd"
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
        bin.install "dpp-macos-aarch64" => "dpp-cli"
      else
        bin.install "dpp-macos-x86_64" => "dpp-cli"
      end
    elsif OS.linux?
      bin.install "dpp-linux-x86_64" => "dpp-cli"
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