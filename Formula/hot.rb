class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.10"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.10/hot_3.0.10_macos_arm64.tar.gz"
      sha256 "46e21f49ded4b59dfa681694ff8be6ef79de180f34db410a8eb9b2e280af57aa"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.10/hot_3.0.10_macos_x86_64.tar.gz"
      sha256 "fb6484b0da56d388ce5067525b8775ebfb75fd7facb61997cbbc2e2200077726"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.10/hot_3.0.10_linux_arm64.tar.gz"
      sha256 "e4c66a2c8173e6c5bdf9bfed251cbb5c174a14e0e1e6d0963998e314a0b3adc5"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.10/hot_3.0.10_linux_x86_64.tar.gz"
      sha256 "504ea4290810625920096d7a95b1a152a91e8c006d54dcb7f6136146d1e099e9"
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
