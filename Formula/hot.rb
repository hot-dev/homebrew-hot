class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.9/hot_2.4.9_macos_arm64.tar.gz"
      sha256 "1f2bce7066f381151ecd23188562491cbaf283861220bb10931421fbadfbe986"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.9/hot_2.4.9_macos_x86_64.tar.gz"
      sha256 "2acac01422a288596940db7d0c28173b1d7b2cf50582d6c4b7753e6f1ace5a7e"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.9/hot_2.4.9_linux_arm64.tar.gz"
      sha256 "9c4ff51905b6dafcff4b729cd6457cd3448bd0daf1712fe0352a716d78f8258b"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.9/hot_2.4.9_linux_x86_64.tar.gz"
      sha256 "ca7a405d40fe3222c746ddddf1f854513c555acdc86096112b0e88e718888b64"
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
