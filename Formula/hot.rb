class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.2"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.2/hot_1.2.2_macos_arm64.tar.gz"
      sha256 "2711a466d0cbe8f6b2f1f63755e2a54a9acba5f310b38c24c1da416b8b907508"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.2/hot_1.2.2_macos_x86_64.tar.gz"
      sha256 "144e4f3a3032d44677e609edcfab146c1fd878acf9820527f1b6c982080c4975"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.2/hot_1.2.2_linux_arm64.tar.gz"
      sha256 "d052b8eae3f7987ec7b78911f13b1e533ee6f311c30025463b4f5cc28b75f78f"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.2/hot_1.2.2_linux_x86_64.tar.gz"
      sha256 "cb1dcf68b40534f8a528a92286f84415bf214568c1de083e6c3ce097b9facb5b"
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
