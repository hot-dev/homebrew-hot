class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.6/hot_2.0.6_macos_arm64.tar.gz"
      sha256 "1bd79d74e3bc7d022d8239e38cd5776ce9bd864f0f86d4d6c93dc5db4506345e"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.6/hot_2.0.6_macos_x86_64.tar.gz"
      sha256 "159ba9439fc25038644ef64802f04bf4149340f9e3b71673262f87d1d15db2d3"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.6/hot_2.0.6_linux_arm64.tar.gz"
      sha256 "75b48e7e61311ce7e2294fa1b2fffa4b4cbb4a91a711e5f7fff071c1cc06066c"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.6/hot_2.0.6_linux_x86_64.tar.gz"
      sha256 "5a8f15ff323e515d3a3722f63b83c6c5e0cacfdcb2d4bae5971aa8c2bf6542fc"
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
