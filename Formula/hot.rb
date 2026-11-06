class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.4/hot_3.0.4_macos_arm64.tar.gz"
      sha256 "65222b0edc2234860115e59cba71c98d2bd23734818eef5c0b19e3071a2a2425"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.4/hot_3.0.4_macos_x86_64.tar.gz"
      sha256 "3e848f4b2694c2cb31bbf92cda2333c88c73fd8e85b359f3dd47cb63093f5a20"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.4/hot_3.0.4_linux_arm64.tar.gz"
      sha256 "467c9914085c8c1806427335b7804a597d05606827f147630f31eaeafb260cf9"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.4/hot_3.0.4_linux_x86_64.tar.gz"
      sha256 "25e949529e32a21292d9884559d40ed562030f577d5fbae9ca5b9b8b6f793da1"
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
