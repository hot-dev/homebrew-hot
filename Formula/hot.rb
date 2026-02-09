class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.33"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.33/hot_1.0.33_macos_arm64.tar.gz"
      sha256 "1a5cb59c69026638dda2862d0ad2d55d5bdfbc627f02c87a0f0e4e11335061ea"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.33/hot_1.0.33_macos_x86_64.tar.gz"
      sha256 "5a313205cf5add943d311738310e52b517348fbb977fd80ec4cbd6be28cd6e91"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.33/hot_1.0.33_linux_arm64.tar.gz"
      sha256 "f8ddf99aa6be93aa400c59e6933d236d2c7805780c153ae0d6ce4419cc213d48"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.33/hot_1.0.33_linux_x86_64.tar.gz"
      sha256 "6eaa4ba78e1a2c60f2fc42bdcbb8cdf39c2a69e5ad27692bb04761a598bd7800"
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
