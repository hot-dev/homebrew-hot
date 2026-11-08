class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.6/hot_3.0.6_macos_arm64.tar.gz"
      sha256 "246be9ab843a629f8c963e3df753d182e083e31926a04bbe1ebc086c551a7ad2"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.6/hot_3.0.6_macos_x86_64.tar.gz"
      sha256 "7dcae5bbcf1b4d87e17be107c5a1f3bc060c14029d86bd71d7538cf9a878a31d"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.6/hot_3.0.6_linux_arm64.tar.gz"
      sha256 "6c778c22ca587bac12fbe587b0fc5f9fba4d81ba0e095b75b29a06258e31bd02"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.6/hot_3.0.6_linux_x86_64.tar.gz"
      sha256 "621fb8f06c6bf9453298d76bbf1a5e4fc812e1a43a5c602fdb6f8a0e34b3a0af"
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
