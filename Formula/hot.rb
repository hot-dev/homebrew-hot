class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.6"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.6/hot_1.0.6_macos_arm64.tar.gz"
      sha256 "45ea952c24114c2f645263746d51cf287f2f253580c3b5a1ce6d23a69a3e7fa2"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.6/hot_1.0.6_macos_x86_64.tar.gz"
      sha256 "d1cc43c2d3a9b87b00c3b8ed08f47433d321a4f0e0b4d90b603b7d78c0eaa53f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.6/hot_1.0.6_linux_arm64.tar.gz"
      sha256 "f6204adbbcdf2bb4a7cda8563e65c67eed00f15c62e3a345825cf39e70a6041a"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.6/hot_1.0.6_linux_x86_64.tar.gz"
      sha256 "f418e1d35cdc1f1db1878845af5eb747927a5c3cbf89226748088aa3dd55ddf6"
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
