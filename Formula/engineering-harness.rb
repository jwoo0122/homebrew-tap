class EngineeringHarness < Formula
  desc "Standalone engineering workflow harness CLI"
  homepage "https://github.com/jwoo0122/engineering-harness-skills"
  url "https://registry.npmjs.org/@jwoo0122/harness/-/harness-2.2.0.tgz"
  sha256 "3fdaaa4f9f5042e821bd90ae3a26b4bb8e1a25e38420fc2f279751fa253f5444"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/engineering-harness --version")
  end
end
