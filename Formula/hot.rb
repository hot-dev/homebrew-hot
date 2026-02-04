class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.27"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.27/hot_1.0.27_macos_arm64.tar.gz"
      sha256 "6dd0db835f01f1edef6bbfdd0ad87e4684b98ac4d1018fa0702a98d5f028167d"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.27/hot_1.0.27_macos_x86_64.tar.gz"
      sha256 "8ec8aaead57c66013c315f042db89c6c3cb2de989be36584855816affd12298d"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.27/hot_1.0.27_linux_arm64.tar.gz"
      sha256 "d858f148862c25f8997d75950b1aa653df98d0d4ceb04096f7d275c500d8397d"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.27/hot_1.0.27_linux_x86_64.tar.gz"
      sha256 "65ffc89aafcd56398bec0daa3f8644d22e5db377a510832768fc9ccd3d42056b"
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
