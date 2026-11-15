class Craber < Formula
  desc "Visualize ER diagrams from SQL DDL or a live database"
  homepage "https://github.com/kobayashiyabako16g/craber"
  version "0.5.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.5.0/craber-aarch64-apple-darwin.tar.xz"
    sha256 "c51cca3778847c9ccd5eda4ebc8da22e2b466e7d39ce4f38546b4dc6ef8bdabd"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.5.0/craber-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e36225e483b2b37c8ddefed80e998be1ea5d008e3ad1aa87313fde35559176d9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.5.0/craber-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7914068d603e81c8d06f250074063eebe2343af62c440e177be8897af23f2034"
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
