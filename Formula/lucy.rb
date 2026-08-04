class Lucy < Formula
  desc "A small local JSONL agent harness"
  homepage "https://github.com/jwoo0122/lucy"
  version "1.14.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.14.4/lucy-cli-aarch64-apple-darwin.tar.xz"
      sha256 "527b731af29ff467d297a17c14276b91c3e48ae3c6c2224d761ac638f2eba2c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jwoo0122/lucy/releases/download/v1.14.4/lucy-cli-x86_64-apple-darwin.tar.xz"
      sha256 "822e575159e73e4c2f34c7bdf72cabff4cadffa3920f539cdaadaf8d6de2df3f"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/jwoo0122/lucy/releases/download/v1.14.4/lucy-cli-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ac2b8ec7a5254719f7b1e94fefe8d69c924d1760156d1ab6e18988ba80545d5a"
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
