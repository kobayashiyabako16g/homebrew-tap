class Craber < Formula
  desc "Visualize ER diagrams from SQL DDL or a live database"
  homepage "https://github.com/kobayashiyabako16g/craber"
  version "0.1.4"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.1.4/craber-aarch64-apple-darwin.tar.xz"
    sha256 "40da6a1ee44545538daaa887e6e5a3fb402d482ce5c6b78b43d3b8730244e997"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.1.4/craber-aarch64-unknown-linux-musl.tar.xz"
      sha256 "812b28df7d521f4f8da84d8d40e8a5df12cd88dbc80ce0a61edf3b2c8a970bea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.1.4/craber-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c2f97460e63017681de88bc242c575f1dd4b9b57cda0c7617258e84a25a8c0d7"
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
