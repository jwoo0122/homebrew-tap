class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.15.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.15.1/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f0ab7272e4e01fda8b8015feea8d4d806b118862915e287ba412423f121110fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.15.1/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fe9607aaed28a9b3dce2f75d125744cd50e9171bfece168d45516d25d80539d8"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.15.1/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c8139b737fd66d6f76aa30cc208e1c83b9baea3eb1abbdd13fd84d1a45300952"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "lucy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lucy"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lucy"
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
