class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.2/hot_2.4.2_macos_arm64.tar.gz"
      sha256 "99d0ec35e82eba95ea1dda412f23d5e2a40389c2d67087c1a11f149543bc923f"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.2/hot_2.4.2_macos_x86_64.tar.gz"
      sha256 "896614d08fbad953ccf2904b8fccac908c779a548088fa35af1255c71d880808"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.2/hot_2.4.2_linux_arm64.tar.gz"
      sha256 "5128048d7fb8b10d972c3302d49e93edce0cde8e05b6acc1a3d7f15e0ed5720f"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.2/hot_2.4.2_linux_x86_64.tar.gz"
      sha256 "a55f964b19940fd5d6fe3120b2f7fbf3af6a7b82db2d50bb7a6912649aaa175a"
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
