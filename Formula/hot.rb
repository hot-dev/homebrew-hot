class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.1.7"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.1.7/hot_1.1.7_macos_arm64.tar.gz"
      sha256 "06da8406c309cfb7f87bc70275686e88ac5c93b2a2b92f99ce912759b5dda18b"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.7/hot_1.1.7_macos_x86_64.tar.gz"
      sha256 "d1f42e839df35351182d3b41c4927de6d3fc12667c191902f3f6a06e0569f90c"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.1.7/hot_1.1.7_linux_arm64.tar.gz"
      sha256 "7ffd55746c217c597f4f13956d653da725d2c11d4da9098577a517d1c7ee1995"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.7/hot_1.1.7_linux_x86_64.tar.gz"
      sha256 "ca3569eee15080c5a28dfe4bb735636ff3eeb240d14d15899c1ba45bc35eefa9"
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
