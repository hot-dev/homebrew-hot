class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.30"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.30/hot_1.0.30_macos_arm64.tar.gz"
      sha256 "b197cba3b84c19bd9e90c5d2458b8472e9ee9dc00522a48f5457be55b1b252c8"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.30/hot_1.0.30_macos_x86_64.tar.gz"
      sha256 "82d618efab751011e055f68e6abf6b0119fa2827f88e9dedc37c5b3b5b908ed1"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.30/hot_1.0.30_linux_arm64.tar.gz"
      sha256 "73a877fea8d3d84568794a52274d88430e0fc38e259f2b7fafcabb4bdb9f9d92"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.30/hot_1.0.30_linux_x86_64.tar.gz"
      sha256 "9c155fe5bf081cbaf9b8323cf082b1d51340884e3d658ad4950b7012dbdbe4fc"
    end
  end

  def install
    bin.install "hot"

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
