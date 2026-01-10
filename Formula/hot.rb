class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "0.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/0.13.0/hot_0.13.0_macos_arm64.tar.gz"
      sha256 "acc5e033fad88b0f43892166ae7db79b604148c5f517ee537b7263238a708250"
    end
    on_intel do
      url "https://get.hot.dev/releases/0.13.0/hot_0.13.0_macos_x86_64.tar.gz"
      sha256 "98cdb38f938d48cebb93c03eb508481d10e2f6e6e67c5909294388053e94e558"
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
