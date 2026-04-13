class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.4"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.4/hot_1.2.4_macos_arm64.tar.gz"
      sha256 "2c5aa29ac9784da204cd63fac7d41271663fa04ba6308a54431b5a55636376a3"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.4/hot_1.2.4_macos_x86_64.tar.gz"
      sha256 "b9079d2b51f67d8d46d71e11b8fa112c31fbc4b0925699b31b6f5832a7a7ef69"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.4/hot_1.2.4_linux_arm64.tar.gz"
      sha256 "01c13477ab05de0db6f11d5f9432c5b10b843aeac8565d4e9bdb690f14a09806"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.4/hot_1.2.4_linux_x86_64.tar.gz"
      sha256 "59e265624922669affcb4066d34b65893505f4eaea1cb2bc94af7b313607de7e"
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
