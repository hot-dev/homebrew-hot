class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.24"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.24/hot_1.0.24_macos_arm64.tar.gz"
      sha256 "95a03ff5c725d19e4195c634d21f4daca61787156c27e2043b1487c24653b1f0"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.24/hot_1.0.24_macos_x86_64.tar.gz"
      sha256 "f1cdd6d4db4e78fd4bc8966f7a1396a6329389462581c9f33194507c628c07c0"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.24/hot_1.0.24_linux_arm64.tar.gz"
      sha256 "eca8c7db7c7ac2577f2f06911f1d3b453b8f415508bc5eeb136d3d40f12c6bee"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.24/hot_1.0.24_linux_x86_64.tar.gz"
      sha256 "11aab255ff2d536f40b80f01ee638fb37e257a02effb444edd0a135d15987c8c"
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
