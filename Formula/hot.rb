class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.2.0/hot_2.2.0_macos_arm64.tar.gz"
      sha256 "9877e9a4c25298cc9eeb06f94179cb48885671a9d954f87174ce441bd5329b6f"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.2.0/hot_2.2.0_macos_x86_64.tar.gz"
      sha256 "934c060faea2e3ec0c3abdd066dfac4f76eff44104f3969c8a2f9156a08ee3fa"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.2.0/hot_2.2.0_linux_arm64.tar.gz"
      sha256 "372514bf82c686ecb252408fac31194cf8f8cc0cf3affe67846009c5cf420061"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.2.0/hot_2.2.0_linux_x86_64.tar.gz"
      sha256 "08ddb7b8391355da2752b8a3f1cc3a00f9a52f5cdbc893b76a370a2cb43a0035"
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
