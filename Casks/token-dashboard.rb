cask "token-dashboard" do
  version "3.0.0"
  sha256 "eeb286f2d7a56ff5e8f818a6936035ed57d3e1761ec2099b7f62a60f311b1e49"

  url "https://github.com/Arylmera/Token-Dashboard/releases/download/v#{version}/token-dashboard-#{version}-macos-arm64.dmg"
  name "Token Dashboard"
  desc "Local dashboard for tracking Claude Code token usage and costs"
  homepage "https://github.com/Arylmera/Token-Dashboard"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "Token Dashboard.app"

  zap trash: [
    "~/.claude/token-dashboard.db",
    "~/Library/Application Support/Token Dashboard",
    "~/Library/Logs/Token Dashboard",
    "~/Library/Preferences/com.arylmera.token-dashboard.plist",
    "~/Library/Saved Application State/com.arylmera.token-dashboard.savedState",
  ]
end
