cask "rebecca" do
  version "0.5.1"
  sha256 "43e8967a39108edfb598466b65276f5120839e2faa7045dc23fd4a33f4e3c8f9"

  url "https://github.com/jwoo0122/rebecca/releases/download/v#{version}/Rebecca-v#{version}.zip"
  name "Rebecca"
  desc "macOS GUI automation tool for AI agents"
  homepage "https://github.com/jwoo0122/rebecca"

  app "Rebecca.app"
  binary "Rebecca.app/Contents/Resources/bin/rebecca"

  uninstall delete: [
    "~/Library/Application Support/Rebecca",
  ]

  zap trash: [
    "~/Library/Application Support/Rebecca",
    "~/Library/Preferences/dev.jwoo0122.rebecca.plist",
  ]
end
