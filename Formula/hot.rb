class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "0.18.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/0.18.0/hot_0.18.0_macos_arm64.tar.gz"
      sha256 "b3a7e3370c1ba146320a8d4ccaba7c7afbf04f2eeadd4faaa5959fa8c9b5ecde"
    end
    on_intel do
      url "https://get.hot.dev/releases/0.18.0/hot_0.18.0_macos_x86_64.tar.gz"
      sha256 "c4b97244fd56ddd9cbcb027681556c3b5539c88ed970218d673171e7e6a449d5"
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
