class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.9/hot_2.6.9_macos_arm64.tar.gz"
      sha256 "1f2582db261d4c6397b978d7da2f6a66f48dd0ec9a111c6f6153597ece8d24d7"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.9/hot_2.6.9_macos_x86_64.tar.gz"
      sha256 "6fa4ddf55708f09118b37a2ef47c15aa447a1ad6bf2aec8f522af23eb95076ed"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.9/hot_2.6.9_linux_arm64.tar.gz"
      sha256 "1c16e9de426a28accef80470533306874e610385cfd896c6764a4d784bf3b51d"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.9/hot_2.6.9_linux_x86_64.tar.gz"
      sha256 "c82e0d25172d1ea97cd333dcb4c2255cdf379cb23e22f9e6620361a08e34dee3"
    end
  end

  def install
    bin.install "hot"

    # Install hotbox Linux binaries (for container tasks via hot dev)
    (share/"hot/bin").install Dir["bin/hotbox-*"]

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

    # Install license and notice files
    (share/"hot").install "LICENSE"
    (share/"hot").install "NOTICE"

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
