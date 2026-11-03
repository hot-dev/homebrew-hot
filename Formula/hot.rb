class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.2/hot_3.0.2_macos_arm64.tar.gz"
      sha256 "30b2a9e990896169b2d0794b089d3f9875007184b54b906e26fe3bae9ff4bcf8"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.2/hot_3.0.2_macos_x86_64.tar.gz"
      sha256 "2e36fa38740c437155bb1fae0ed76469af5ae61224ddd1dc7590930a5165ed54"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.2/hot_3.0.2_linux_arm64.tar.gz"
      sha256 "da39cc90534e9b0edf91bd0cc6ff5e82f896a0ebec409e354d9ecc478f1df1ac"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.2/hot_3.0.2_linux_x86_64.tar.gz"
      sha256 "cb1e52ea685a39cda58504353b7fb119a9d86c4ccb13d66ccc16c8d37994bb6f"
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
