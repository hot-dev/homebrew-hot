class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.8/hot_2.4.8_macos_arm64.tar.gz"
      sha256 "2a0183197cf98f7471712fc7f1ee7a825de0450bf1fb435b82ec18438edd89be"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.8/hot_2.4.8_macos_x86_64.tar.gz"
      sha256 "4a78e1fc623ed1077865c7be4b2729b4e2fea245526dc352161484c90856cb00"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.8/hot_2.4.8_linux_arm64.tar.gz"
      sha256 "7dff1fcceaca4f1dbfda3f3f3510a2368391f17eb561a23369d6912cc96b8c25"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.8/hot_2.4.8_linux_x86_64.tar.gz"
      sha256 "1a6eb6ca16e0c7811c36056bfe57be8564035373e84d93e8632cc2fbc9b860ef"
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
