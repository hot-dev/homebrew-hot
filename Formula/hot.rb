class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.6/hot_2.6.6_macos_arm64.tar.gz"
      sha256 "30a159000ea42a9ede9a60a256a217034275419d7a0a8955f239fd1aef7da909"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.6/hot_2.6.6_macos_x86_64.tar.gz"
      sha256 "002adb9100ea33c05b6ba3bbe63186562bf59c2f91c051f886a82bf123ff2f37"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.6/hot_2.6.6_linux_arm64.tar.gz"
      sha256 "aeee898e378b2f749edfbb4ca8d801621348ed7bdb1518df112f1c45017215fd"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.6/hot_2.6.6_linux_x86_64.tar.gz"
      sha256 "10559616d133f87e9f62ea4292ce5db30a9be598c11cd2e7ad89381b470196fd"
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
