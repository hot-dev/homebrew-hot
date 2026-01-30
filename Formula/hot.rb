class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.22"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.22/hot_1.0.22_macos_arm64.tar.gz"
      sha256 "1c00cf1874cb4ab1ed9742ffad809219ebce13732624fe5fcb5668d0ebbeaa28"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.22/hot_1.0.22_macos_x86_64.tar.gz"
      sha256 "8784bfb2808e5419a646e6afacd753f35e87b02537fe8853fd421de43d3be0dd"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.22/hot_1.0.22_linux_arm64.tar.gz"
      sha256 "a10c1873e5501bb1d4c123470315a22ee3a52a48a1ac59f9b8c1739a629a6990"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.22/hot_1.0.22_linux_x86_64.tar.gz"
      sha256 "c51b987215662e33b287e241eb1b2bdb73ad9a38dc4c118b44ef636bc89ad2d4"
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
