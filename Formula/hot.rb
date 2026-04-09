class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.3"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_macos_arm64.tar.gz"
      sha256 "b82bd1b4657529248e61976fc33722d4e611f478411fb4791fc4dabeef19d3f7"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_macos_x86_64.tar.gz"
      sha256 "6373c6acdc2c8c3f047ff6279eb2db58df4a9403d13e06b91cfad6d939c7ff3b"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_linux_arm64.tar.gz"
      sha256 "a6bde8543a91c2421ff4d9d504cba27227c7635d2af887caf27b70022a58149d"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_linux_x86_64.tar.gz"
      sha256 "29b8e7907b8d61cbea151ee3bd3d4b700bc192820c84719fcd74641d97a0ce65"
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
