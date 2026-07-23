cask "rebecca" do
  version "0.4.0"
  sha256 "4edf6f6d659703caf483f6f464424e1833ca4b3ec048a30c544a6362ee7bfa02"

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
