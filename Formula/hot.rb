class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.1.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.1.1/hot_2.1.1_macos_arm64.tar.gz"
      sha256 "d3c23fa0bc177ee79ede439deca04a3542a376b8567a94eba26208fa5b5c6fd7"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.1.1/hot_2.1.1_macos_x86_64.tar.gz"
      sha256 "192698ed4e6e081944ed83eb7668048f57e357e3844c90b74c08308dbc706682"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.1.1/hot_2.1.1_linux_arm64.tar.gz"
      sha256 "0a079cd57561ee3b80b4b821c843cf4003cf03e1bf5f0eda5151cf8df6f1f101"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.1.1/hot_2.1.1_linux_x86_64.tar.gz"
      sha256 "2f3943bdb153a0e50362ae6c651d692b387860fff2f93bf2ad884c6877a92129"
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
