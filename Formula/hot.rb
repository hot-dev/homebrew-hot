class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.0/hot_3.0.0_macos_arm64.tar.gz"
      sha256 "1e76e60960a4ac3d241f16521019390cc24a8f86848d130d234a1e9c58e51b6f"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.0/hot_3.0.0_macos_x86_64.tar.gz"
      sha256 "d50e8c3017f046b5f8183bd18a6a22a0287ac541ea9db2c2e8b26099ac4562c4"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.0/hot_3.0.0_linux_arm64.tar.gz"
      sha256 "6e966e8c8aeda4e3c0245b55cfc451a7b34eff3abd98a822f59acca7835b9c6a"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.0/hot_3.0.0_linux_x86_64.tar.gz"
      sha256 "0f7850a44fff623f50ff41701ef92785357225b51e7b2605582a7c7d3a8a82a2"
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

    # Install license and notice files
    (share/"hot").install "LICENSE"
    (share/"hot").install "NOTICE"

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
