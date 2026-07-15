class Tony < Formula
  desc "Manage Git worktrees and attachable agent sessions"
  homepage "https://github.com/jwoo0122/tony"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/tony/releases/download/v1.0.0/tony-aarch64-apple-darwin.tar.xz"
      sha256 "91d2e90c311aef96189ee792e6c4f9b6e63614f7dbe2a80d4207e9e3e5ac1119"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/tony/releases/download/v1.0.0/tony-x86_64-apple-darwin.tar.xz"
      sha256 "f7c9e8f07c0427cd127d949ac9b1a762216fd4f461b227f7311ffffbc51bfdcb"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/tony/releases/download/v1.0.0/tony-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "1bd7b22623c7a9a71dac4f873765d89f59bdec69a5684628d597924890397ea8"
  end

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
    bin.install "tony" if OS.mac? && Hardware::CPU.arm?
    bin.install "tony" if OS.mac? && Hardware::CPU.intel?
    bin.install "tony" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
