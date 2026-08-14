class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.14.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.14.9/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "38760c3c996e45b98e52ff2cf1271f47a4f168c8058cd024fcff6b7640c7f61f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.14.9/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8d91fca8d9fa13af8acdbdc32544874a8cb59abffa6fc9fd8eea8e4a5eae6c85"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.14.9/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "71fbbf2c5ebbd972186d7854f0d0d528d60d7aaf6ea27ef802a853a562ad389a"
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
