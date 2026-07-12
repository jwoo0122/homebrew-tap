class EngineeringHarness < Formula
  desc "Standalone engineering workflow harness CLI"
  homepage "https://github.com/jwoo0122/engineering-harness-skills"
  url "https://registry.npmjs.org/@jwoo0122/engineering-harness-skills/-/engineering-harness-skills-2.1.0.tgz"
  sha256 "f6f3b678c137941952971f40f1379e8340f86f80b80addcbba3798e2abb8eeb1"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/engineering-harness --version")
  end
end
