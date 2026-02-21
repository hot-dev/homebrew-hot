class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.1.3"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.1.3/hot_1.1.3_macos_arm64.tar.gz"
      sha256 "eba8a10413c71846cd56eece9e29b6bb5881a8c8ebbd297e955d604700e07fa5"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.3/hot_1.1.3_macos_x86_64.tar.gz"
      sha256 "57b96b5a11533014b880ec3c30d268d076cd69f0a4ad3cf580a1d675a34d8c8a"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.1.3/hot_1.1.3_linux_arm64.tar.gz"
      sha256 "7901e4aa5759eecd21ec18a88a7a2108b7f647121510263eff5786fcc51467aa"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.3/hot_1.1.3_linux_x86_64.tar.gz"
      sha256 "87b77a8abba6818e86d35eb3b7b4e2cedbe9e05d24b74dc0976f3283b8e2a110"
    end
  end

  def install
    bin.install "hot"

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
