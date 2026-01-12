class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "0.16.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/0.16.0/hot_0.16.0_macos_arm64.tar.gz"
      sha256 "e2c48640780de1b4772053b143a2f38c912d361db701f9b4a6f699b6106541d9"
    end
    on_intel do
      url "https://get.hot.dev/releases/0.16.0/hot_0.16.0_macos_x86_64.tar.gz"
      sha256 "2ff81762c50fa8de6a8bbedbd2bae3e065d1db2ca4a8f0a577ec150b57807eb3"
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
