class Craber < Formula
  desc "Visualize ER diagrams from SQL DDL or a live database"
  homepage "https://github.com/kobayashiyabako16g/craber"
  version "0.2.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.2.1/craber-aarch64-apple-darwin.tar.xz"
    sha256 "5af74a9df0657671a87693d4fcac2b18177e5169bf9886ad2ace425aa0cc0836"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.2.1/craber-aarch64-unknown-linux-musl.tar.xz"
      sha256 "0a3c5466986dfbe3f5803d24d3354773474a2d1042c1594dac8d129658b59a75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.2.1/craber-x86_64-unknown-linux-musl.tar.xz"
      sha256 "750aa77b56035f3556392a81eaa9eee14089b96276c29051387487bf2d8f0cf5"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "craber"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "craber"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "craber"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
