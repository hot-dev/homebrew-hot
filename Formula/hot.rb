class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.3/hot_2.6.3_macos_arm64.tar.gz"
      sha256 "d0d45771f44dd592751305c74f670ed0948b42c57b82d8685a72c23e3cf2ecc6"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.3/hot_2.6.3_macos_x86_64.tar.gz"
      sha256 "4d4efad1ab547b8b0e44e849e40af4fc5d254ce2491cb92a1d4eda13e7216011"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.3/hot_2.6.3_linux_arm64.tar.gz"
      sha256 "859b5bfa5d7bc985937474b7b5542f24f735fec68419b31622dfd744163663b3"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.3/hot_2.6.3_linux_x86_64.tar.gz"
      sha256 "ea89ab1195f37b6958c1b9505eeb21808de9e5597212dff0804fb93412fbb466"
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
