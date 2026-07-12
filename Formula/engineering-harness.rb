class EngineeringHarness < Formula
  desc "Standalone engineering workflow harness CLI"
  homepage "https://github.com/jwoo0122/engineering-harness-skills"
  url "https://registry.npmjs.org/@jwoo0122/engineering-harness-skills/-/engineering-harness-skills-2.0.3.tgz"
  sha256 "a5ccb35beda9ba1aadb5d87cc16eb347bda144ed6f5975c0a5c18fbf39eb936b"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/engineering-harness --version")
  end
end
