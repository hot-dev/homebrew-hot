class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.3.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.3.3/hot_2.3.3_macos_arm64.tar.gz"
      sha256 "bddc6aac9e98993450ad8b77ebeec488a8ba5437f147be75c2991402a92f467e"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.3/hot_2.3.3_macos_x86_64.tar.gz"
      sha256 "0a91a83e711583c841c54375c38f77dd05440b412b30ac4cf541eb5c6a3ecbe7"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.3.3/hot_2.3.3_linux_arm64.tar.gz"
      sha256 "644653465a262f2de963045d3814ac9d14392008e8513d348cbb5048b0b46c25"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.3/hot_2.3.3_linux_x86_64.tar.gz"
      sha256 "2766b9f1aa525b830ecd18b2270ce8846838064edba3b7184bde0f0a60f8e095"
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
