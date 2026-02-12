class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.46"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.46/hot_1.0.46_macos_arm64.tar.gz"
      sha256 "6514d39f878544847b3909ec24ab34de83f7610fe657e87e492746b75eb933e6"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.46/hot_1.0.46_macos_x86_64.tar.gz"
      sha256 "9cc8566983a0b0884c17b1132f3d97799ea664a31c4b18a7b6704ff88ea89fe9"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.46/hot_1.0.46_linux_arm64.tar.gz"
      sha256 "ca96eaa00085d10466e65b57cd6515f8086c02b65d8b3277dca18b1267e454bf"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.46/hot_1.0.46_linux_x86_64.tar.gz"
      sha256 "9ae79df4919ac7cb4e6912045095029498bde015b089007c3798e0384f17e9ef"
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
