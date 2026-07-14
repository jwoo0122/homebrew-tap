class EngineeringHarness < Formula
  desc "Standalone engineering workflow harness CLI"
  homepage "https://github.com/jwoo0122/engineering-harness-skills"
  url "https://registry.npmjs.org/@jwoo0122/harness/-/harness-2.3.0.tgz"
  sha256 "2a434962129e51464971cb7b7e56c586bcbe31bb4dbf48dd00bebe2d8e95a16d"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/engineering-harness --version")
  end
end
