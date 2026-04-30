class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.1/hot_2.0.1_macos_arm64.tar.gz"
      sha256 "e910c46e1dca9804ebcd56c804efda317bb636d74c25003c5557d277b4fb3c06"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.1/hot_2.0.1_macos_x86_64.tar.gz"
      sha256 "5d5473410a8d0ab6a8ef7b1301c35f3c00e4abbba9dce9a806d5a08800c365a8"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.1/hot_2.0.1_linux_arm64.tar.gz"
      sha256 "3763941c5c01f99e9648b05016fe759382ade5c0fdcf0312611a07c5ba39eed9"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.1/hot_2.0.1_linux_x86_64.tar.gz"
      sha256 "cc12eb2028e56a085e512a67d7fc7702fd182513ef673c97a4c392776136cb40"
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
