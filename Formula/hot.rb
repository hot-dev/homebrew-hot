class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.2/hot_2.6.2_macos_arm64.tar.gz"
      sha256 "95904c41fa2fc813bec63ab70501567757bf09d9291bdad83a47fc1ea38330bd"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.2/hot_2.6.2_macos_x86_64.tar.gz"
      sha256 "485639cfed78d123e482c6c7e0bc016ed0239c104b51026760fb5fd84fc6a1d7"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.2/hot_2.6.2_linux_arm64.tar.gz"
      sha256 "88e32d217714ad10932ec02b2f2c0edb0e50a585f961ea1256a7a07762fade96"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.2/hot_2.6.2_linux_x86_64.tar.gz"
      sha256 "86327194d3a5fa1347ce06a89b33c9f60fde6c0e359d3c3c243954a45564d379"
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
