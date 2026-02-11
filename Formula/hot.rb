class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.41"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.41/hot_1.0.41_macos_arm64.tar.gz"
      sha256 "ccd2d450d66393722356ca54c95bae243ef806914f674c4480b67848cb19ea9f"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.41/hot_1.0.41_macos_x86_64.tar.gz"
      sha256 "980e3f2df3f9f070dba819cb0057ec4979e2fedde25c71c7965cdbebd3068d18"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.41/hot_1.0.41_linux_arm64.tar.gz"
      sha256 "f7678198042cec3881d4d92ee698fd057ad92d97631f89427e4bbe9e0317628e"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.41/hot_1.0.41_linux_x86_64.tar.gz"
      sha256 "45f0cf9079b6943a234e2547aa9221f5fa270a929bde713fe794be4f8d4bdf52"
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
