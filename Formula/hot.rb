class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.1.0/hot_2.1.0_macos_arm64.tar.gz"
      sha256 "beff7205fbd9da31c212b2dbfb4d6c9c5954111eaf4b4a90986ee1cbac3d73bb"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.1.0/hot_2.1.0_macos_x86_64.tar.gz"
      sha256 "14a8b529f281fa17db6b619d39fa66dbe2ac3e91986560826fb8e058a79ba201"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.1.0/hot_2.1.0_linux_arm64.tar.gz"
      sha256 "e19bbce3ca0f1238861aba333450d6fd3beae56342010d6417a6d13dfd0b343c"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.1.0/hot_2.1.0_linux_x86_64.tar.gz"
      sha256 "dea4e66aecd2d089811e2672101cf45a104a99ccce104b9347ae6120d0bf6d21"
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
