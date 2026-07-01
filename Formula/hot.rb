class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.12"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.12/hot_2.4.12_macos_arm64.tar.gz"
      sha256 "722342ee5731b5e5cb71d7eda5cb315edf79339c3a28fb4ed0c2a5b39ff09db9"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.12/hot_2.4.12_macos_x86_64.tar.gz"
      sha256 "80ded92402a17881afbf00f16bc40823f21f2f0b39db4f9d56205946a8dcc9e1"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.12/hot_2.4.12_linux_arm64.tar.gz"
      sha256 "eac8883f36d236699461dc37343b3ce20ee5fbcbd2a2b1a4866683cce836a229"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.12/hot_2.4.12_linux_x86_64.tar.gz"
      sha256 "f6ade8ee4fd691a8cac5124eaa3e9ac5b18afb7e58d7c47caa2cff03bcd362dc"
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
