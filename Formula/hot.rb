class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.2/hot_2.0.2_macos_arm64.tar.gz"
      sha256 "f50f8f8679bc3e59749170ccff71c321b60d08919354747d079a7d5c0d0213dd"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.2/hot_2.0.2_macos_x86_64.tar.gz"
      sha256 "5c8f4cd285901cfc8c3099e1faf22353c78d2896bcf5cbc46e1ee635cb955a29"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.2/hot_2.0.2_linux_arm64.tar.gz"
      sha256 "a45be058bf5cffdac4c0e4480ac03a222121b7d30a4a00dfddcf8369349fa0b4"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.2/hot_2.0.2_linux_x86_64.tar.gz"
      sha256 "c443232597bb9e75f56aa169c0372671ffe33f2cede0c30a706081047454587f"
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
