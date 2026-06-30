class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.10"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.10/hot_2.4.10_macos_arm64.tar.gz"
      sha256 "1de1455055e7967b85e64d642334a8b554cf7611d42d051ffe956740ac9fbe05"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.10/hot_2.4.10_macos_x86_64.tar.gz"
      sha256 "5886464182700d3d1fef5cf2f6e44440999e02075bf3fc649105bbf7104f9642"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.10/hot_2.4.10_linux_arm64.tar.gz"
      sha256 "5ff521dcc6c3334fdffc14012a0fc7450c2de891cb679bcdd5e494972abc077d"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.10/hot_2.4.10_linux_x86_64.tar.gz"
      sha256 "5046ba27127a06c8554cba071ad29de0dbae1078946a4f3f54ba30ca46cd0b79"
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
