cask "token-dashboard" do
  arch arm: "aarch64", intel: "x64"

  version "5.1.6"
  sha256 arm:   "c55d77b27aecae270f4adeae13aabd80420c2666f9ad65df47186056f1b4d223",
         intel: "af3de0beb4de76c1b0bae1cd0628447d762da7fdc771d699615d43ab99818fca"

  url "https://github.com/Arylmera/Token-Dashboard/releases/download/v#{version}/Token.Dashboard_#{version}_#{arch}.dmg"
  name "Token Dashboard"
  desc "Local dashboard for tracking Claude Code token usage and costs"
  homepage "https://github.com/Arylmera/Token-Dashboard"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Token Dashboard.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Token Dashboard.app"],
                   sudo: false
  end

  zap trash: [
    "~/.claude/token-dashboard.db",
    "~/Library/Application Support/Token Dashboard",
    "~/Library/Logs/Token Dashboard",
    "~/Library/Preferences/com.arylmera.token-dashboard.plist",
    "~/Library/Saved Application State/com.arylmera.token-dashboard.savedState",
  ]
end
