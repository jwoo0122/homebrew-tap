class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.8.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.8.4/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6f586047e037f829756b39c8c3aa3700bf2a5e96bb7f85cf7b6d5739bb187c1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.8.4/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e14cca2e9c8044a25fce8fab5273223675f02b3af460a668c766176660fc3989"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.8.4/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "697fad0e576c77df4f7e0175b4d8f9e1add653cbd1c12f66605f82075a8393c0"
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
