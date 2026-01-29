class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.17"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.17/hot_1.0.17_macos_arm64.tar.gz"
      sha256 "755382d53ed35901860819aa6d6a4b552dea6cd7238ba2c9314729a376109e62"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.17/hot_1.0.17_macos_x86_64.tar.gz"
      sha256 "8cef5c841ab27ec31f8cf83810c9bab942f63866ffa19bdf4adbc7267cc1ab96"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.17/hot_1.0.17_linux_arm64.tar.gz"
      sha256 "74e8d20af0bd654833f3abb15d387676b0e6ec2d27a7fcd803d1683980ac6481"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.17/hot_1.0.17_linux_x86_64.tar.gz"
      sha256 "294e978e6100b93ba1021a06ca8279b5098dd8c11fb0bba4bbde843d809f9386"
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
