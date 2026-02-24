class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.1.6"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.1.6/hot_1.1.6_macos_arm64.tar.gz"
      sha256 "8760921e500f24a672af345391b4a32aa670aa5d9141458df1b778cc2693e1f3"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.6/hot_1.1.6_macos_x86_64.tar.gz"
      sha256 "f155d14e3e6e9eb03bd0d29b9a27f164812f5d8cf9d18efff2746a8321cd4b4a"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.1.6/hot_1.1.6_linux_arm64.tar.gz"
      sha256 "6a416853c6b82c51879c106b5a66eea4e53827228e6995b47e128f001252ed09"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.6/hot_1.1.6_linux_x86_64.tar.gz"
      sha256 "ec6a1e86be474aefb1a852ef98654f816617dfe3f0fe9bc9aedf8093e077e0d4"
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
