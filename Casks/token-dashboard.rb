cask "token-dashboard" do
  arch arm: "aarch64", intel: "x64"

  version "5.1.12"
  sha256 arm:   "7af85d8353d1880383db2fc6270444b85204ceefeccf6541b3b0c7f69d4b5f6e",
         intel: "3783a33d0480ee427ebc1aa6513c2e7bc06b952d24233f4a2544ecbfa30d3128"

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
