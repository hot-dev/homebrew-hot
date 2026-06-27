class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.3/hot_2.4.3_macos_arm64.tar.gz"
      sha256 "5acb18c0c8f4dd71bb921d552cd3343e78a3ae49f1bbeaf7d836bcb8c435051d"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.3/hot_2.4.3_macos_x86_64.tar.gz"
      sha256 "511dc34960061e57f0d4858fc9c8e2f90f93bd6d8a2d571ce4c3cfe85e8341df"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.3/hot_2.4.3_linux_arm64.tar.gz"
      sha256 "1b976ecb069e62bba1595725404d7f52ddbaae98644f91a855ee037b21bbe8b8"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.3/hot_2.4.3_linux_x86_64.tar.gz"
      sha256 "5be47f93d6a5334101b9d2becc2a5e86487e43fa8f753af46c5d9669b4be2a6b"
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
