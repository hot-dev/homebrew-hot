class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.8/hot_2.0.8_macos_arm64.tar.gz"
      sha256 "7c3c6cba077a3900e8afccef3d3722985ee805184216406244503426369dd122"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.8/hot_2.0.8_macos_x86_64.tar.gz"
      sha256 "2be66c6fca2ed64190df095069c3e44b26ce92aa926f35bb32f4ec73d1b9abf3"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.8/hot_2.0.8_linux_arm64.tar.gz"
      sha256 "a31abed0581ac32996c805162ff540135e3e9cd6ae8f49768c6b3a836abf66eb"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.8/hot_2.0.8_linux_x86_64.tar.gz"
      sha256 "bee0023bfff5189d9ced6233acd6e1849c83029a8cec52d0dc3ebad2adfd1df6"
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
