cask "rebecca" do
  version "0.3.0"
  sha256 "c3fea1d51587dadf9486aad9853da81a8024320d2230916f3ccd9418ebabbb8c"

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
