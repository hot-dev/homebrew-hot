class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.0/hot_1.0.0_macos_arm64.tar.gz"
      sha256 "f38cf1462e738d7a999ace6d29923e903641ef244fc2e01ab17e68e97604ecbf"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.0/hot_1.0.0_macos_x86_64.tar.gz"
      sha256 "d0d846566f445dd059eeae650d7af54da97c733758ef801f8cda76fa4e711e8f"
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
