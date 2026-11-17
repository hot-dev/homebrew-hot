class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.11"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.11/hot_3.0.11_macos_arm64.tar.gz"
      sha256 "7619d4fede91030a0d1f924aa71a17d8a098d2b6870da0088853fe1d9bbaa682"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.11/hot_3.0.11_macos_x86_64.tar.gz"
      sha256 "a825f0de3df9268d9875ec03dc4412bb290b3c9fc6245751db4fdae03299e44d"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.11/hot_3.0.11_linux_arm64.tar.gz"
      sha256 "d77a8a6e37cdc5331bbf504ad5ba03d17fdda4ddc24d3489bc1c14d83912d984"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.11/hot_3.0.11_linux_x86_64.tar.gz"
      sha256 "15cc7c8e476533d6b156f5a4d364d161499a10d36272677da52a6a0f65d6d9f3"
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
