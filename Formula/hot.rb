class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.5/hot_2.6.5_macos_arm64.tar.gz"
      sha256 "eb9127dac3831262903ed6057310c8262c886c323b412894d8faa7b2b34b7a3b"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.5/hot_2.6.5_macos_x86_64.tar.gz"
      sha256 "6ceef06d1eae65d13416bc709205d497795d54b8cc3077f5dcd83aa4db918a57"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.5/hot_2.6.5_linux_arm64.tar.gz"
      sha256 "da0239ee36e6053789dead07e65a3c7c81619056ce5e90c5afec27b6ea5f3fd1"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.5/hot_2.6.5_linux_x86_64.tar.gz"
      sha256 "f00e112b83e4f4226957da148c508df27f1f5a3d46aa4e5c366da57d84e61eec"
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
