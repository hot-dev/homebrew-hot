class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.1.2"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.1.2/hot_1.1.2_macos_arm64.tar.gz"
      sha256 "65d64b58e1592fb4d4fd52a9aba8609b6902a4dd3a1e9bf1fc2ee09d857f6b69"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.2/hot_1.1.2_macos_x86_64.tar.gz"
      sha256 "1aad5eefe7ebdcad5bb4640b4b3e7f1f8021d4e26db1d1c9dc328446d6c9f9e6"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.1.2/hot_1.1.2_linux_arm64.tar.gz"
      sha256 "85e895a4393ca0c54eddd3a70a9a705342518ba6891b8558f4e20c765143705e"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.2/hot_1.1.2_linux_x86_64.tar.gz"
      sha256 "32a696c173a17f328960df6d3908c6c3f056739047da70f10c1d5cf3620a31f2"
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
