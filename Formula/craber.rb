class Craber < Formula
  desc "Visualize ER diagrams from SQL DDL or a live database"
  homepage "https://github.com/kobayashiyabako16g/craber"
  version "0.3.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.3.0/craber-aarch64-apple-darwin.tar.xz"
    sha256 "8a674df8095e8a8c9c68cc33267dfe55a004179d8b4635b2d1cc8418bda71a87"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.3.0/craber-aarch64-unknown-linux-musl.tar.xz"
      sha256 "03a4c1de624f90d0be0401c3989a5e529277e5bb84a4d31c74b8d9718c25d439"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kobayashiyabako16g/craber/releases/download/v0.3.0/craber-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2714b9072c7180e4caa3f480afc9cfd4e4e6f46013bca1ae937f923fc47d7424"
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
