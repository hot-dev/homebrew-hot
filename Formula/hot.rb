class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.3.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.3.5/hot_2.3.5_macos_arm64.tar.gz"
      sha256 "ac9f5e5933b0b6b20f832c3201a1edd448b000159d4565d6941f8365c99c465c"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.5/hot_2.3.5_macos_x86_64.tar.gz"
      sha256 "255da60794544c20f4d30785aae738acdb202bc2f71697ac2975c7c8ac9ee944"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.3.5/hot_2.3.5_linux_arm64.tar.gz"
      sha256 "8a6d2e26d255760040e299166a034976dbfce8ebc5ec565a9153c38f3469bbec"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.5/hot_2.3.5_linux_x86_64.tar.gz"
      sha256 "015f1dc55a315700895353c112daba4768fab50c2e145ed2ba1763a27d803f79"
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
