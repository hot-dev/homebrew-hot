class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.5/hot_2.4.5_macos_arm64.tar.gz"
      sha256 "8febae86507465ff8264cc4a388a222e7ce85d39a4592411465bc5e3c1dfbcfd"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.5/hot_2.4.5_macos_x86_64.tar.gz"
      sha256 "80752b9b751eb93358e9dd4eb7e4cbcf653694f90acef0b982884b83cb02b582"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.5/hot_2.4.5_linux_arm64.tar.gz"
      sha256 "e60fb5c8c6b80cba1ede5195b826dc2471fd4e7f32fe6de8044519ae0e473704"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.5/hot_2.4.5_linux_x86_64.tar.gz"
      sha256 "d82c054e152f8b3e56509b1c3725a00d92fd6ede2e6e63e5cfa1f619e9070136"
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
