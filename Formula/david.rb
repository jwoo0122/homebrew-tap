class David < Formula
  desc "Manage Git worktrees and attachable agent sessions"
  homepage "https://github.com/jwoo0122/david"
  version "1.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/david/releases/download/v1.6.0/david-aarch64-apple-darwin.tar.xz"
      sha256 "b9e5453741be00484c928062e057adbd8ceeadbec01b1096e9ee823249122115"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/david/releases/download/v1.6.0/david-x86_64-apple-darwin.tar.xz"
      sha256 "380a278ee90a72739161c4aeb653f8a98b730098625a222d8fda6c2601776a2c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/david/releases/download/v1.6.0/david-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "eb5611a0636f5e204ecfcb902ac3c744ebd7b016dbbe931341b3ffdcb3f02d3a"
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
