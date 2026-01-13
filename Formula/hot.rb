class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.1"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.1/hot_1.0.1_macos_arm64.tar.gz"
      sha256 "967e6d512020ac23a88afc19dfaa02388311c36d50e5dcd4ca50b1afa4bd1a56"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.1/hot_1.0.1_macos_x86_64.tar.gz"
      sha256 "10a8c9cccbd74ff6fa123a0511e0a224576fb369aa46b09c5d874922333191a9"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.1/hot_1.0.1_linux_arm64.tar.gz"
      sha256 "47d75df0d6e4bf29f84f2671168adc2d4fba4f82bd0ad27633f11b4ff5b76bfe"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.1/hot_1.0.1_linux_x86_64.tar.gz"
      sha256 "0a2fb6783539593bfc0003b2eb95a66020d34132fd0f1d4dee0152d7ac342022"
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
