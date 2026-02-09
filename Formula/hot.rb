class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.36"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.36/hot_1.0.36_macos_arm64.tar.gz"
      sha256 "389b750993869fe50059ff72fae8a07ca9a0cdba58c2dc5ec090b9bd1564678e"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.36/hot_1.0.36_macos_x86_64.tar.gz"
      sha256 "a8b9c3ec9a42f25fce6b169c084e2d1da3a12e9ad178f8814ffb1ac961ca6e1f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.36/hot_1.0.36_linux_arm64.tar.gz"
      sha256 "73407a4680f5e22aede2fe8c4236216657bc225f60053c83b5b362f441872d77"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.36/hot_1.0.36_linux_x86_64.tar.gz"
      sha256 "6159abe11f5f20c8b291d3c045bfcaf65f72e07ed4a2077cc70e39db8a2c4cc3"
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
