class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.5/hot_3.0.5_macos_arm64.tar.gz"
      sha256 "63e7a35fa6b1a9563dcead82ae7bc05d7c4d67670e1df5a45d113a7d58561b4b"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.5/hot_3.0.5_macos_x86_64.tar.gz"
      sha256 "0ab2494219a0b10223ce30270813bc143c273c258ca9148cba2311427338c395"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.5/hot_3.0.5_linux_arm64.tar.gz"
      sha256 "48b1f9071d32383ac652bbf98dbe43de10cc3de66ae3984bc3d47de9ebbec5ea"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.5/hot_3.0.5_linux_x86_64.tar.gz"
      sha256 "be1eb26f2bebe8557feb6a484dc3b7780d5f00d559a4adce077115855489fc1b"
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
