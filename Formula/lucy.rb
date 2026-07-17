class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.3.0/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b19898da5476d798618d614ddfdb1065e7be13e382d29265a5997d63fb9a1f36"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.3.0/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a4d38165211aeab94a5168bb711b3ff0de231b7672a50478e2ff31068578e877"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.3.0/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ceaebd2d0945a718c783ba53aa758d538b746a7262a37b5c06113db26fd0d3ac"
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
