class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.15.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.15.2/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "73c90f205d14c832b77ad82c11612106515a36031913fb1e08cdbfbaa5b9a0fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.15.2/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "cfeeba38cbdc104c7a261fc33547b237ee766870707bc20877697648e15d6b16"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.15.2/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4136d2fdcb6fc384a6e5437e7de99c8a494d9958eaa72a61e7f62c58782e85f4"
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
