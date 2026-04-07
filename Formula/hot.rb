class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.0/hot_1.2.0_macos_arm64.tar.gz"
      sha256 "bef123132f5c94e8b6305f92b03be92bf1601e0db727aadc25e326e0947706aa"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.0/hot_1.2.0_macos_x86_64.tar.gz"
      sha256 "0c3543298da94362c70e14f4bf45b96e5c078acd0e6b5e5306427fa55f69852f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.0/hot_1.2.0_linux_arm64.tar.gz"
      sha256 "b6a206f0df3c40d0cec9c7919ab6a77af05005d69734133a1f36ed7c05e18492"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.0/hot_1.2.0_linux_x86_64.tar.gz"
      sha256 "4a22f3ad22a342ee87754c9e882189b098d4342f4bbbaf47971bbefb95a2c6a3"
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
