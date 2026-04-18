class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.3.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.3.0/hot_1.3.0_macos_arm64.tar.gz"
      sha256 "9acfac96592def168db0251c074f81bd168d08a58d7c2e8b916f0692004c3b62"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.3.0/hot_1.3.0_macos_x86_64.tar.gz"
      sha256 "98e7ab4708aebb9f85c0b4bfb85c2f86101d53d271ef99455fb8fa8b4bf9da13"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.3.0/hot_1.3.0_linux_arm64.tar.gz"
      sha256 "c6c427e508a4eb68dd4e80de2321fe360a9c73b6f3824c19747763eaa0d6b9ce"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.3.0/hot_1.3.0_linux_x86_64.tar.gz"
      sha256 "aac6df9c12f1bd29b2a39f9858daf5397194a0710b4749a6e818131481acc638"
    end
  end

  def install
    bin.install "hot"

    # Install hotbox Linux binaries (for container tasks via hot dev)
    (share/"hot/bin").install Dir["bin/hotbox-*"]

    # Install standard library
    (share/"hot/pkg").install "pkg/hot-std"

    # Install database migrations
    (share/"hot/db").install Dir["db/*"]

    # Install app assets (CSS, JS, images for dev server)
    (share/"hot/app").install Dir["app/*"]

    # Install AI resources (AGENTS.md and skills)
    (share/"hot/ai").install Dir["ai/*"]

    # Install init templates
    (share/"hot/init").install Dir["init/*"]

    # Install license file
    (share/"hot").install "LICENSE.md"

    # Generate and install shell completions
    generate_completions_from_executable(bin/"hot", "completions")
  end

  def caveats
    <<~EOS
      To get started with Hot:
        hot init myproject
        cd myproject
        hot dev

      Documentation: https://hot.dev/docs
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hot version")
  end
end
