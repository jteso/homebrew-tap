class Luminatti < Formula
  desc "A fast, mouse-aware worktree diff review TUI"
  homepage "https://github.com/jteso/luminatti-cli"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jteso/luminatti-cli/releases/download/0.1.1/luminatti-aarch64-apple-darwin.tar.xz"
      sha256 "68c42c3dea31681b7421d821ba83c570c3488ff86bdd8026a653a1a4b28ba43d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jteso/luminatti-cli/releases/download/0.1.1/luminatti-x86_64-apple-darwin.tar.xz"
      sha256 "b3556aeea390d1545081dd49dbfa996ee0891de87f5eab8e947976f98a392576"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "luminatti"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "luminatti"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
