class EngineeringHarness < Formula
  desc "Standalone engineering workflow harness CLI"
  homepage "https://github.com/jwoo0122/engineering-harness-skills"
  url "https://registry.npmjs.org/@jwoo0122/harness/-/harness-2.2.1.tgz"
  sha256 "1d780a72863e984a955b1aeba1c27ba9a1d0c500dceb10f093edae07e6cc24b7"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/engineering-harness --version")
  end
end
