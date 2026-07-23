cask "rebecca" do
  version "0.5.0"
  sha256 "ae728001f35b990379694b21e00d6cbd877927f6bf98b1ef7e3bce7ceb34a080"

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
