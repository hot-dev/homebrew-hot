class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.29"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.29/hot_1.0.29_macos_arm64.tar.gz"
      sha256 "6f7156c6b4e2936aea626cec55a464fd9a3048ee8a16dc2a7f89e8fd08829486"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.29/hot_1.0.29_macos_x86_64.tar.gz"
      sha256 "959b516aee8a460241ec3558f54e7e3f0298a0e324860e26e89e2f47f6d52a59"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.29/hot_1.0.29_linux_arm64.tar.gz"
      sha256 "1e6b9f9eee8834a6d3e1302a2257e1e6a06b0e4dbe7055fa4abae09f20443713"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.29/hot_1.0.29_linux_x86_64.tar.gz"
      sha256 "4268aa0fcf1e95b444bf2b4d26bbfe2237bf0ffe39f9f341ff0f52c46da88a0f"
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
