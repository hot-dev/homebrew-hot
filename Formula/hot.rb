class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.5"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.5/hot_1.2.5_macos_arm64.tar.gz"
      sha256 "2c4801734ef250a910b43ba7744afcccf8de490a8cc647c0efc5f3d389a9f817"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.5/hot_1.2.5_macos_x86_64.tar.gz"
      sha256 "c7eefa9fcd2463171d7f84df8e66f87aee18a11d3e7894f5e1b10748df9d2649"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.5/hot_1.2.5_linux_arm64.tar.gz"
      sha256 "23c6636fb09a44a9f26d2acc168a1283a5901514ca3dd528fa675fc4eadecf56"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.5/hot_1.2.5_linux_x86_64.tar.gz"
      sha256 "22a1783410132ea2b2ed5c9cfc2058b49dacc596f40339a8ae5fe1d82a3011f8"
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
