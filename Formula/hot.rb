class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.1/hot_2.4.1_macos_arm64.tar.gz"
      sha256 "290d53a3e38db385dc793b0815a3021c7d1de708c3395d1f24fbcebd427a3a27"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.1/hot_2.4.1_macos_x86_64.tar.gz"
      sha256 "af45eb2105926754d9eea5e2d322daaf7881f7d72db9fb40250cf6994ec77981"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.1/hot_2.4.1_linux_arm64.tar.gz"
      sha256 "e2337504ef6ca3170fba90ee1dd4c25229799219427210ab8f8f5995b643b54c"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.1/hot_2.4.1_linux_x86_64.tar.gz"
      sha256 "588e25e1075c30ad38e92db041b1d4c3eef8fd0511042dfa9f088c6b1877871d"
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
