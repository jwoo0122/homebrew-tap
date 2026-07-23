class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.8.0/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "de56cbfc91a863e9df5042bafc5a20692046c51a4ebe30fb0bbc64bce162509f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.8.0/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3dbd3e93b34e1560ddb134c84f9866eb94d3595a96f25ec3ee5e9f08b34541b7"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.8.0/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "fb04f279cf6b735e59942ab1529bbd0c855a467133e9551e397fd8509f9826bb"
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
