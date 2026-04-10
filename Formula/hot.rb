class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.3"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_macos_arm64.tar.gz"
      sha256 "bebd90bfba18dd576a33914b84992209c3af5e5522d2801e3e5db5029a086edf"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_macos_x86_64.tar.gz"
      sha256 "24a7e94237e77122aaafbd1fcb9333361cc7e21fdcde0679a436a5e9927838f5"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_linux_arm64.tar.gz"
      sha256 "a0fe3cc0318f0fd4b0016275c42c7894eb90c02785c0e48a7a21617347750fd3"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_linux_x86_64.tar.gz"
      sha256 "b82625fe06ada1d3b7597b5b0754dda96915922d63719669721208c0e04038ef"
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
