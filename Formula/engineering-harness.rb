class EngineeringHarness < Formula
  desc "Standalone engineering workflow harness CLI"
  homepage "https://github.com/jwoo0122/engineering-harness-skills"
  url "https://registry.npmjs.org/@jwoo0122/engineering-harness-skills/-/engineering-harness-skills-2.0.2.tgz"
  sha256 "54aa1d122874bdf15b82ea460a58db1c2d3e7a804816899d125bd35c85bb5d48"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/engineering-harness --version")
  end
end
