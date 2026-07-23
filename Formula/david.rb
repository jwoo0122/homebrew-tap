class David < Formula
  desc "Manage Git worktrees and attachable agent sessions"
  homepage "https://github.com/jwoo0122/david"
  version "1.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/david/releases/download/v1.7.0/david-aarch64-apple-darwin.tar.xz"
      sha256 "cd8cf7eed9aa70e203a756a0b6c6cb99619eae64d0f204a8bbd1c656a70193c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/david/releases/download/v1.7.0/david-x86_64-apple-darwin.tar.xz"
      sha256 "83c50d747483942fe5b4bdeea0c8a52abc223112bdf07faba5f8bd18b3d5e495"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/david/releases/download/v1.7.0/david-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "22531fbb4d67df8df2742fea19b80c0c5fcb0aeb4ca4e0ba2aee7fe18325969e"
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
