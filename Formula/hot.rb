class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.35"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.35/hot_1.0.35_macos_arm64.tar.gz"
      sha256 "033d1a7ddb8f1b88b262836b49710951ab9f08e4e87fec232fe04dea289886dd"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.35/hot_1.0.35_macos_x86_64.tar.gz"
      sha256 "7ecd1d06aa8bf2b2646d8dc890c2974ed85817b58aaba36551266cfda52eb91f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.35/hot_1.0.35_linux_arm64.tar.gz"
      sha256 "8a6a1b7ac8af2f172b4c983210ab43c232f9b08f1614566ce0a3b9300d10d0aa"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.35/hot_1.0.35_linux_x86_64.tar.gz"
      sha256 "c10d3646a5564c5090be743dbbd98eb748c71e69ce74b281e065f89eddf1d395"
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
