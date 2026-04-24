class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.4.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.4.0/hot_1.4.0_macos_arm64.tar.gz"
      sha256 "1e94e1eff313734dccf7f156d770cfaa670f0d41ebb8b69bbbd0b4be987e24d2"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.4.0/hot_1.4.0_macos_x86_64.tar.gz"
      sha256 "e295661d6e5180733ced93d19a519e3eb3c078335471cf89768afb0eef63c735"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.4.0/hot_1.4.0_linux_arm64.tar.gz"
      sha256 "113612d65b40d4f1b36b5068415ae5942a313cb79fdb5141fbb735b9e4600f1d"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.4.0/hot_1.4.0_linux_x86_64.tar.gz"
      sha256 "309834ca9f7b45793bc3ca4719b969d817d64f994187d0a6a09b6539d867bbef"
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

    # Install license file
    (share/"hot").install "LICENSE.md"

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
