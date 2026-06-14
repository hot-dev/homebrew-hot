class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.3.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.3.4/hot_2.3.4_macos_arm64.tar.gz"
      sha256 "441b51b7947f5e2ac461919db3e19fe59f13d3a7a70fcf1da80e28e67101b1bc"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.4/hot_2.3.4_macos_x86_64.tar.gz"
      sha256 "f7ebf9d52c037074d100b50e9034f0e45ab3ac405fd00222fe941dfc31e05b5c"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.3.4/hot_2.3.4_linux_arm64.tar.gz"
      sha256 "42d6f4b8d4446d74023eceea8c4dcb6b870f9fee7575400f0078e8a1c36651ae"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.4/hot_2.3.4_linux_x86_64.tar.gz"
      sha256 "7cecb6ff863c47b6dcfae9f5d6eabace8d4a09388fb6129f30c522f30c4d3c39"
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
