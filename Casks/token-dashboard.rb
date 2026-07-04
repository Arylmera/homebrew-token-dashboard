cask "token-dashboard" do
  arch arm: "aarch64", intel: "x64"

  version "5.1.1-validation"
  sha256 arm:   "1291763c6973adbf9fb96be0e75408222d7d2df18e834317cff7213a3b627aaf",
         intel: "1eaa24820a31494f64b45cc97f4aa2622d57b0633765334103c09e6919301822"

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
