class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.42"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.42/hot_1.0.42_macos_arm64.tar.gz"
      sha256 "48a051e56736ce576545e6674b32d96cc25bf2fea3add796014df8016c20f4e4"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.42/hot_1.0.42_macos_x86_64.tar.gz"
      sha256 "0478abfed4288a260e036c8fe7e03fb0804cd55f050390c8572503958bb763b3"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.42/hot_1.0.42_linux_arm64.tar.gz"
      sha256 "8f3694112f5dccb55f01649a55ccb8aa1a2cef6f8cde2349f944f77c5fe25471"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.42/hot_1.0.42_linux_x86_64.tar.gz"
      sha256 "b2fdd75b95047ce316cb305d38372b1c21178b4d3306a3c22a2e2fb2e61e275f"
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
