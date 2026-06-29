class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.7/hot_2.4.7_macos_arm64.tar.gz"
      sha256 "a5dd7e74719876fecb29c81113243482ddeaa5c7ebb36ad8a569918f18e72bb0"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.7/hot_2.4.7_macos_x86_64.tar.gz"
      sha256 "cad6f4a40ec0015bd7dabf4a3f63e5afa8807b6619c27afc710d504c1c7e1869"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.7/hot_2.4.7_linux_arm64.tar.gz"
      sha256 "6bebe9ad0ee6fa5ea29685a4a10328ef0578345f1a2046106f81e61bc98675bb"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.7/hot_2.4.7_linux_x86_64.tar.gz"
      sha256 "4ace3bc20b581be1fa2b02a4fb1d662f1bb51c753f6a585118008619ea617605"
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
