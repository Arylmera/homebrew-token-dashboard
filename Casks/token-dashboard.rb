cask "token-dashboard" do
  arch arm: "aarch64", intel: "x64"

  version "5.1.9"
  sha256 arm:   "5972303700915953ca41b2f4e5450cd5d07ad846eb5d1a5db465e5234dd93cf6",
         intel: "b52a1e4996c405e93ff8c3db43d5e53e6539b70d27c3a75fab25abd66c950894"

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
