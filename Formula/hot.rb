class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.40"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.40/hot_1.0.40_macos_arm64.tar.gz"
      sha256 "2c5d261e65e04587ce3d34527d979e3efb9147698c846f7a5686620464353129"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.40/hot_1.0.40_macos_x86_64.tar.gz"
      sha256 "235d3fe3511d8cc1828d61129fbf3dce7d653fa9382d542fc8623328482354dc"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.40/hot_1.0.40_linux_arm64.tar.gz"
      sha256 "a05068cfffbd2a21b87c58d543d8a64b1772d1c39cbe60a4a460c7a7f49bd702"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.40/hot_1.0.40_linux_x86_64.tar.gz"
      sha256 "870c3a2aacd4d0b70ed7db9b4d86cab09c48d8bd85582b8bcb3db00a49354a28"
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
