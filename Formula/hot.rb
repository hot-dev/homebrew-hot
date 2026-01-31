class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.23"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.23/hot_1.0.23_macos_arm64.tar.gz"
      sha256 "441fb3cb42b48bfb9ba71ed9c20e9b959fa425ee9c94a2706ae812c43a34e200"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.23/hot_1.0.23_macos_x86_64.tar.gz"
      sha256 "31e96b32297eee744eb44cd2063684fd85d024a54896b4796894d9a067163022"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.23/hot_1.0.23_linux_arm64.tar.gz"
      sha256 "290376d5e65922882146a9e1d38a08d6744b16a250086cc93e8298af1fdadfb0"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.23/hot_1.0.23_linux_x86_64.tar.gz"
      sha256 "5b9dd71d18f00d90dcbc891b1600ca76aa8529d55895db8d37726cae3a17c706"
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
