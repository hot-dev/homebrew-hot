class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.3.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.3.2/hot_2.3.2_macos_arm64.tar.gz"
      sha256 "1ce97860f8e4d27144833daaabeaf2118d92c98d2026eff86fd4222958fe217d"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.2/hot_2.3.2_macos_x86_64.tar.gz"
      sha256 "207dcee1e11b4f25b1d9425267e014c518b17aebfbd9212ad369bbb07d5a47ce"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.3.2/hot_2.3.2_linux_arm64.tar.gz"
      sha256 "9be9031b6da2be26e831a60126c80e7bc5ce32bc5379162557308a0eeb6f8c08"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.2/hot_2.3.2_linux_x86_64.tar.gz"
      sha256 "afe3d8ccb60840a496635246dbc9c114713dc7fc56db83636be8b16d4a21dfba"
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
