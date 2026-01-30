class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.21"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.21/hot_1.0.21_macos_arm64.tar.gz"
      sha256 "e489c14ed5fe0034988a4b1e066479394993466555198ddc0d7cca9c54a6e350"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.21/hot_1.0.21_macos_x86_64.tar.gz"
      sha256 "a75ef4998d6d041a780a2b098bc388d947c8ddf2c51936a2c98b9ef6fb04b35f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.21/hot_1.0.21_linux_arm64.tar.gz"
      sha256 "9bc67634f347e3d5fab31a3a4bb36c1f11829474e1dc74a3062ed2b901dcd9cf"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.21/hot_1.0.21_linux_x86_64.tar.gz"
      sha256 "4c60b5999bbcc50065acfd25ad6460eddbb6241a8cbc7de7f39c0fe6cbf2331d"
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
