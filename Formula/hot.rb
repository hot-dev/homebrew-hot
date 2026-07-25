class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.4/hot_2.6.4_macos_arm64.tar.gz"
      sha256 "61faf56e2cf3a841a86cacbfb5558bac9e0cdd76fdd8582c155a87165c3d90aa"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.4/hot_2.6.4_macos_x86_64.tar.gz"
      sha256 "473e26907232e703ab58e34093bebcc0f9a7c1fd7e3c73a4501a9bf2eeb9220d"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.4/hot_2.6.4_linux_arm64.tar.gz"
      sha256 "c5d6519cd919842a8a6c2b0ee945f0865386e44c4e5b58867d6c596022d95082"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.4/hot_2.6.4_linux_x86_64.tar.gz"
      sha256 "f19f8c8928a68ec3fd26f757af3ce6f159385360fd5f27c48fd7c54ad69715e2"
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

    # Install license and notice files
    (share/"hot").install "LICENSE"
    (share/"hot").install "NOTICE"

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
