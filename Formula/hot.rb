class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.10"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.10/hot_2.6.10_macos_arm64.tar.gz"
      sha256 "433da5b274ebf7d61e10f5728250ace9bf03830f9a08a59075cea5c0e0e244d7"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.10/hot_2.6.10_macos_x86_64.tar.gz"
      sha256 "27e3864a264272b6176ba832472515a283c0e6eaaa705fdaca6b6865879ad694"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.10/hot_2.6.10_linux_arm64.tar.gz"
      sha256 "22d81939b135719f18fcb98acbd784f5abed591fb5423e95339bd792b3d0c392"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.10/hot_2.6.10_linux_x86_64.tar.gz"
      sha256 "34ddcbb14aaab072ff3c0b69ccaad68ce3eaa13f2d56a18fbda23e340840c099"
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
