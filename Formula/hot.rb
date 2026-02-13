class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.48"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.48/hot_1.0.48_macos_arm64.tar.gz"
      sha256 "f4756a47bb1302859b03045ffd2c7d920965a2341065135f17288bf723bad630"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.48/hot_1.0.48_macos_x86_64.tar.gz"
      sha256 "d8fb128a75ee5600990f7fd09637f088bf9c3985282269e9e853494b4aac0dfb"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.48/hot_1.0.48_linux_arm64.tar.gz"
      sha256 "a4add9ef03a54adeb6492440efa9d6722b8127780bf5f99107d082adf3582f5a"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.48/hot_1.0.48_linux_x86_64.tar.gz"
      sha256 "ccd3183731a1771e0506e4c136cc03921646d799236d23850e399e2608438332"
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
