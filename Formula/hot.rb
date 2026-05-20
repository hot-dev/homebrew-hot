class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.5/hot_2.0.5_macos_arm64.tar.gz"
      sha256 "ab54617bb6dfe2bc8aa3cbde3e1c32d8d000e1abb03930177a8053f8db2adbec"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.5/hot_2.0.5_macos_x86_64.tar.gz"
      sha256 "ec73d04db1e1dd843b005bb926446ebf79cf626eab0a40f893766e3bf388e0ae"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.5/hot_2.0.5_linux_arm64.tar.gz"
      sha256 "8ba8a1072731604deb312efa433485efac1870044b190eecef2b319f7f6bcabf"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.5/hot_2.0.5_linux_x86_64.tar.gz"
      sha256 "f57ac03e98de66525509df643f22ffc3f39898d6d3e9c104fc78a6fe3505d87a"
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
