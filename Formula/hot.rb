class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.32"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.32/hot_1.0.32_macos_arm64.tar.gz"
      sha256 "0777c7042c5abcf35ead25b9b80c026eb835b010b8a1207a50301780e40b770b"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.32/hot_1.0.32_macos_x86_64.tar.gz"
      sha256 "a27923c064580cb4380ff7dc4e88deba487eb6d2fb0b449f862ee6a352770f4f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.32/hot_1.0.32_linux_arm64.tar.gz"
      sha256 "59055dbfa7b5f7bfa6bbb4356d8555871076b93b7b3ab4bcbc66340fd26edc62"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.32/hot_1.0.32_linux_x86_64.tar.gz"
      sha256 "28b0472f49219b6c13e6b5631ce5a5a6eded7f610e56fcabd4314269fd8fe145"
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
