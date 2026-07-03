class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.5.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.5.0/hot_2.5.0_macos_arm64.tar.gz"
      sha256 "074e6ecd7e45a58d139cc77e0d333dd021887b1d1522775b01860e29b94e68f3"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.5.0/hot_2.5.0_macos_x86_64.tar.gz"
      sha256 "d8dcc71bdab55f9915ca0d1365b7604c48fd73a0d1c42e035fbee138708f9e93"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.5.0/hot_2.5.0_linux_arm64.tar.gz"
      sha256 "82c650658da8b2807b32cd9041870fa94fc606febe5bd88458574f2092df3983"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.5.0/hot_2.5.0_linux_x86_64.tar.gz"
      sha256 "7ae374aac9961cd8e84d6d4f3f821e8ddaafeb2a88c3c4d001efbf33f6ebd05c"
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
