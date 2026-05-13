class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.3/hot_2.0.3_macos_arm64.tar.gz"
      sha256 "8b4ff2445ad6518e6580558da85de83e04beba6a93e0f8f44dd673f35c9fe24f"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.3/hot_2.0.3_macos_x86_64.tar.gz"
      sha256 "5f2410988328cc8b1c150e00eb3c7ccb84d85b5798a9d0bb5de4f1264526d014"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.3/hot_2.0.3_linux_arm64.tar.gz"
      sha256 "bde60616c3acd6fbc91ff7aea285656869648138f736030b138e85956f60b4c9"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.3/hot_2.0.3_linux_x86_64.tar.gz"
      sha256 "b770f11b609b28c13b6d0320cd14daee9a9437fb81ec9dbbf79ad9b2930a7d21"
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
