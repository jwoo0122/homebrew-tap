class David < Formula
  desc "Manage Git worktrees and attachable agent sessions"
  homepage "https://github.com/jwoo0122/david"
  version "1.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/david/releases/download/v1.4.0/david-aarch64-apple-darwin.tar.xz"
      sha256 "b40a6de143c450d5f4e404fd4967f0fa3fec9999a803903094e3a343fa8e63e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/david/releases/download/v1.4.0/david-x86_64-apple-darwin.tar.xz"
      sha256 "22868cd29bbc33704d3f8fc27b8d144bb9a9daf90d5b04044337a33f39533975"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/david/releases/download/v1.4.0/david-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a48bd60459513d119417486c695340b3dc0d3163448018c125e05436e839f47f"
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
    bin.install "david" if OS.mac? && Hardware::CPU.arm?
    bin.install "david" if OS.mac? && Hardware::CPU.intel?
    bin.install "david" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
