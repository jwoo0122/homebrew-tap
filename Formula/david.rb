class David < Formula
  desc "Manage Git worktrees and attachable agent sessions"
  homepage "https://github.com/jwoo0122/david"
  version "1.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/david/releases/download/v1.10.1/david-aarch64-apple-darwin.tar.xz"
      sha256 "d97296a35fc822b7d4142f89648f3ccaf0851091aec8b61cf0bfb56e7b165476"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/david/releases/download/v1.10.1/david-x86_64-apple-darwin.tar.xz"
      sha256 "e1591d6916d41e76331038c0b9d58437097384676b1086413a443c4c5e99cf97"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/david/releases/download/v1.10.1/david-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "5630a8323f6db5a0485af315b14a194849eb6ac049c89c274bfbf68f0fac5e48"
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
