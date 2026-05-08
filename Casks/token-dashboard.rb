cask "token-dashboard" do
  version "3.0.8"
  sha256 "fd2f97bd04a98f2f5b00517af096ed9832ccbe0c9d127dde654468a29ac78361"

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

  # The DMG isn't signed with an Apple Developer ID (only ad-hoc), so even
  # though Homebrew Cask normally strips quarantine on install, recent
  # macOS releases re-attach it. Strip explicitly so first launch doesn't
  # hit the "damaged and can't be opened" Gatekeeper dialog.
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
