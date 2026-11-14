class Craber < Formula
  desc "Visualize ER diagrams from SQL DDL or a live database"
  homepage "https://github.com/kobayashiyabako16g/craber"
  version "0.4.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.4.0/craber-aarch64-apple-darwin.tar.xz"
    sha256 "132d8e6b3acd218871dcd7942070015f4b44f8afa1ee3836e0660e9d6eb2e216"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.4.0/craber-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6b44622390d429b724c7006fde0cfe5026347d30707e0ef2ab529e9faf998fc3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.4.0/craber-x86_64-unknown-linux-musl.tar.xz"
      sha256 "5691d781fc0dbcb200092e704af7f43a70f3fc8609355254494a0980964f747e"
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
