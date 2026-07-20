class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.5.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.5.3/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3393f830a70df0a4663f1b9833a7c3e11993d453ec4ec63c3230dd12ecf645e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.5.3/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "da4ef5467ed6c0a5994fae95ff794bae71f3e306af617b8a87abdf48212e2240"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.5.3/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4efc79962045807402a8493b177bbed1a149c763ac6ea9d95048bc813dfe2d8c"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "lucy" if OS.mac? && Hardware::CPU.arm?
    bin.install "lucy" if OS.mac? && Hardware::CPU.intel?
    bin.install "lucy" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
