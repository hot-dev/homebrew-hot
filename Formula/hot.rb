class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.3"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.3/hot_1.0.3_macos_arm64.tar.gz"
      sha256 "14611fca5df4597ca687823ebff7554980013de8779f18651f68e51d86c7ec82"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.3/hot_1.0.3_macos_x86_64.tar.gz"
      sha256 "61d46157b9cf9fbee8a30416c2346c8414691fe0f0ee8de7c9e488d3fe251191"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.3/hot_1.0.3_linux_arm64.tar.gz"
      sha256 "61b05eda43fbac51a09fac5a817b5af561d98d5658a5fe84c42de403f0895204"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.3/hot_1.0.3_linux_x86_64.tar.gz"
      sha256 "f85b53626c87856730097ef4cf0fd06fc95d655e9b0c24c0ece6c54ab1a82f88"
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
