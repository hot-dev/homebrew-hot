class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.0/hot_2.0.0_macos_arm64.tar.gz"
      sha256 "662932687b384744272740c5dd96951753af055d612a1fcaa108db8e3e060d01"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.0/hot_2.0.0_macos_x86_64.tar.gz"
      sha256 "1a7e24d5b84f250f8041767af837386ac487993e6947c11a379b9a52d608c523"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.0/hot_2.0.0_linux_arm64.tar.gz"
      sha256 "1f6c50b2d11de46dbd50948d56ab0aceb7a4cbac965831af5d342327a866e988"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.0/hot_2.0.0_linux_x86_64.tar.gz"
      sha256 "146ec52660bbda0ce43a5fbbd1066fd19b0af6e1d02effab1f29e6bb2b4724a5"
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
