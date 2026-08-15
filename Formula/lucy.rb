class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.15.0/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "58b9eab83359dcd9b405684db5da282a9eae81babf276fdb5fc173f1ef945738"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.15.0/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f30bd39724b19b91f12789d914b60a9d56351a41ec60fed9b7fe79f913a84834"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.15.0/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "fdecc1085a5621938b41db906159b7a0086f26591bfa26af0cb6afe7142ec072"
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
