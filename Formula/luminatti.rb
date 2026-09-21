class Luminatti < Formula
  desc "A fast, mouse-aware worktree diff review TUI"
  homepage "https://github.com/jteso/luminatti-cli"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jteso/luminatti-cli/releases/download/v0.1.0/luminatti-aarch64-apple-darwin.tar.xz"
      sha256 "46069141c9a5895c110a3f0fc8cf777c167c1fac5dddd1bc31a74c45cf76225f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jteso/luminatti-cli/releases/download/v0.1.0/luminatti-x86_64-apple-darwin.tar.xz"
      sha256 "1df6aee023e202025628ef01a4b0e1f355b71ca952bd933dbfd858a88da7be8e"
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
