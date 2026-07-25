class David < Formula
  desc "Manage Git worktrees and attachable agent sessions"
  homepage "https://github.com/jwoo0122/david"
  version "1.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/david/releases/download/v1.8.0/david-aarch64-apple-darwin.tar.xz"
      sha256 "bf09db5d869e340564f89e5d11b1a781072f57787efcddfa963636a013f9afcd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/david/releases/download/v1.8.0/david-x86_64-apple-darwin.tar.xz"
      sha256 "26fc483a16a7716aceb7a1c4a3d5ec025713ad68a0d0f54eb5cddbc2af4005d3"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/david/releases/download/v1.8.0/david-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "b44b7615705eac79ae13a2ffd898c7b8b85f2447d96a6ea24c38235cb8e30992"
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
