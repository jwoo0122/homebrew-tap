class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.16.0/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "51bf32330560ae9f52023ddbdf57e1d110d96a4858a897cabb60466188312702"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.16.0/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f3b73e54af38386a537288e1cd8171e841dc9081499ee8fea11c58fae89cddf2"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.16.0/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ba581cdeaeb2e64f08d097a94a50739d4f0e1c255fde309462280d0cc491ee86"
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
