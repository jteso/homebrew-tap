cask "luminatti" do
  version "2.32.1"

  on_arm do
    url "https://github.com/jteso/luminatti/releases/download/v#{version}/Luminatti-macos-arm64.zip"
    sha256 "46bdd45cb93837e5b408ba92e125b72755360a35d20f6dffea5f191b3b7bb580"
  end

  on_intel do
    url "https://github.com/jteso/luminatti/releases/download/v#{version}/Luminatti-macos-x64.zip"
    sha256 "6539256438d5f9cdb364297b3619cf316f64a63a809dcf51d6faa7c60ea2b305"
  end

  name "Luminatti"
  desc "Native macOS code review workspace"
  homepage "https://github.com/jteso/luminatti"

  app "Luminatti.app"

  postflight do
    system_command "/usr/bin/open",
                   args: ["#{appdir}/Luminatti.app"],
                   must_succeed: false
  end

  caveats "Luminatti is unsigned. If macOS blocks it, use Open Anyway in System Settings > Privacy & Security."
end
