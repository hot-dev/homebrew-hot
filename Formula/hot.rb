class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.31"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.31/hot_1.0.31_macos_arm64.tar.gz"
      sha256 "6e7148e6f56d5e64a495a3e06cbef3a882c83818042c2864577b8767b78e3c70"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.31/hot_1.0.31_macos_x86_64.tar.gz"
      sha256 "e07ace17b85dd2839ec4a1a7c16ef141d5e994d139f0e04a11e939d50262679f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.31/hot_1.0.31_linux_arm64.tar.gz"
      sha256 "c0b171cb93ebcafad8b2a1bc4ab69c049b18b25d88b01c862f5657e30c7c3b77"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.31/hot_1.0.31_linux_x86_64.tar.gz"
      sha256 "5cd47756f92724d55422ea5e22d7f93766870d232f75586fd42b686bb2099c5d"
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
