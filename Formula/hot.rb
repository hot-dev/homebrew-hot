class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.7/hot_2.0.7_macos_arm64.tar.gz"
      sha256 "357c6c90db211fb9190611a52d7a8ab3f7da414c78a3a90762bc7d8949e3baf1"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.7/hot_2.0.7_macos_x86_64.tar.gz"
      sha256 "f72e04211b5b8cf1c054f21cd46b1b6c70a982a7af5002682b60384db5241e69"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.7/hot_2.0.7_linux_arm64.tar.gz"
      sha256 "9e8b1f1941a0e720e76bc4034815bda9f32be299e85fee26090fa5eb5fe5952f"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.7/hot_2.0.7_linux_x86_64.tar.gz"
      sha256 "4c6de137f6e508aa589bf6b44c5003b043d3b5ae7d5f6c897e13aab957bee617"
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
