class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.3"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.3/hot_3.0.3_macos_arm64.tar.gz"
      sha256 "63e3e8f96564c893f9f32e2567eb5145879a57c64332d30ff036e19a872f81e3"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.3/hot_3.0.3_macos_x86_64.tar.gz"
      sha256 "eedf2e42951dbc4b6425e3da352ebbcaf5cda5a575ccff4c6e90dd72df2d6773"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.3/hot_3.0.3_linux_arm64.tar.gz"
      sha256 "6e277378d4abcc52ede82d685a7f9094f39d89f7d8fa7617ba894b957a74d89b"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.3/hot_3.0.3_linux_x86_64.tar.gz"
      sha256 "d3e90a2718cf4c2f8373d05e3961fc8650e1d62d113372cee43f46a38301135a"
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
