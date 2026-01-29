class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.19"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.19/hot_1.0.19_macos_arm64.tar.gz"
      sha256 "73808df1eb828ce4e95c53e93287796514c43aa27f32719217c25f57baa47f98"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.19/hot_1.0.19_macos_x86_64.tar.gz"
      sha256 "4f9d56ef3c4e502a5f8f0a8cf23365affa48e8abe9179efaa2263c5b708bfd01"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.19/hot_1.0.19_linux_arm64.tar.gz"
      sha256 "679a824dfdb86d39ef4ecd3929992c33619d9f32eeb8c3b513f84ff647b4c81d"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.19/hot_1.0.19_linux_x86_64.tar.gz"
      sha256 "c59d4deed15430ea6701d358137034ad1be393b1d90f4817ffbd0347b4ca1767"
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
