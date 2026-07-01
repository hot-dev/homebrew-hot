class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.11"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.11/hot_2.4.11_macos_arm64.tar.gz"
      sha256 "2391b1e11adfc298d6b3e18fdfa0d009297c592d0b785cc424a8279ad12455ef"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.11/hot_2.4.11_macos_x86_64.tar.gz"
      sha256 "81da860598a1560bf953d5b0d88cec520aedf3e1f6b5e8e7332470eafa5c0f23"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.11/hot_2.4.11_linux_arm64.tar.gz"
      sha256 "0e0a05eaf3f812739df6192518aac02af90eeb34016ae67fa697637f6d39bfc9"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.11/hot_2.4.11_linux_x86_64.tar.gz"
      sha256 "49f938335c46b62eaeb82339e888219c7619b95539d2c37f6674f565c0c96c0c"
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
