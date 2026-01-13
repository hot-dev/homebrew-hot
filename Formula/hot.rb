class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.2"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.2/hot_1.0.2_macos_arm64.tar.gz"
      sha256 "5e90a797d8dd5e204c5b8c53bf30e67b7b4293679f329a681f11ad77d83feaab"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.2/hot_1.0.2_macos_x86_64.tar.gz"
      sha256 "e4dbfb49de5b5f06daef7531147dd638d92e839a4d527efca8c7b4e66f48182b"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.2/hot_1.0.2_linux_arm64.tar.gz"
      sha256 "2e4f80c3f0fa95a3cf6ac9a0c4ff6a5449acbff5043c182aabe54d5873ebe44d"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.2/hot_1.0.2_linux_x86_64.tar.gz"
      sha256 "e75f1603391f507b41ee2609f2c9fc69a8ea10c053ee05f27ac2dcc22d7f3c42"
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
