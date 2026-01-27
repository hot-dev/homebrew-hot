class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.13"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.13/hot_1.0.13_macos_arm64.tar.gz"
      sha256 "afd0ec1b7faa117d4dd49bdf722f91ad0d9019cf21cdd9359291022acfe31e75"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.13/hot_1.0.13_macos_x86_64.tar.gz"
      sha256 "643c05601c24fab9d054ccfd30630c97c89f5ed3b93f0260e7769e8a6d3ac19e"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.13/hot_1.0.13_linux_arm64.tar.gz"
      sha256 "d7ea953b4c2dac535439eb49ff1fbab4e0a9d1454e76fdcab25b99920f5828ef"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.13/hot_1.0.13_linux_x86_64.tar.gz"
      sha256 "cadb4d264c5951b23dfb1b7c9540c9479e57e0be9a6d0a96b42733eb40b820af"
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
