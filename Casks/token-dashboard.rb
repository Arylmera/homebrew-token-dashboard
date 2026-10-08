cask "token-dashboard" do
  arch arm: "aarch64", intel: "x64"

  version "5.1.10"
  sha256 arm:   "4243ab764aefd1405a9ed755d9c71cc0998a1e758c49c5f50bce6b50f24c1c84",
         intel: "e0b06ef273e40b914922563063c6369e85659cd91619c71c9170d486df0df044"

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
