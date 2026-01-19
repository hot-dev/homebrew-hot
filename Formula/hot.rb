class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.7"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.7/hot_1.0.7_macos_arm64.tar.gz"
      sha256 "5f7f3fc7f214740748616f52a52994ca08d2560357cd37cf8395cb61402b22cd"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.7/hot_1.0.7_macos_x86_64.tar.gz"
      sha256 "b29b22658f986d0cca712e9ab1bff9bdb6c224ab5627d7090be62cde11b8a1b8"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.7/hot_1.0.7_linux_arm64.tar.gz"
      sha256 "461384df1b4c9c4a5b4ec72c58a5e69f98ed151a307dfb1f7a1e67a81023fc37"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.7/hot_1.0.7_linux_x86_64.tar.gz"
      sha256 "cb6bff1d4427b0fd2948b69efdc474ae2c09f604f0027c7c5693cc2c5974f05a"
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
