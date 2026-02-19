class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.1.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.1.0/hot_1.1.0_macos_arm64.tar.gz"
      sha256 "815981eee71a4a17fa7fccaac178c21de390bcd4f6f261d9728d8c23b1e476cb"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.0/hot_1.1.0_macos_x86_64.tar.gz"
      sha256 "0218fcca0406c6cca7a88444c6a1c3030c598c109a72c05064942e7cc68a88e9"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.1.0/hot_1.1.0_linux_arm64.tar.gz"
      sha256 "525e2bcb5f259c5118408d098fd6687ca8e261859436c823873fe64f21a5d087"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.0/hot_1.1.0_linux_x86_64.tar.gz"
      sha256 "2b9466555dda77335e0c1681e898b1b0e0e2fd1afa4c4e6f9b36da21a7de61d5"
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

    # Install AI resources (AGENTS.md and skills)
    (share/"hot/ai").install Dir["ai/*"]

    # Install init templates
    (share/"hot/init").install Dir["init/*"]

    # Install license file
    (share/"hot").install "LICENSE.md"

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
