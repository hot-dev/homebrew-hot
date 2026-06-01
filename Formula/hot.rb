class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.3.0/hot_2.3.0_macos_arm64.tar.gz"
      sha256 "5958ed51ae4b2fc97b942d466110c0cd9de8428c76a200b9acdcfdf6315ee2bd"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.0/hot_2.3.0_macos_x86_64.tar.gz"
      sha256 "267dd49ce4b60cba00631f95a92e3c58892efbd79b5fbbd722ebc62eae8a80cb"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.3.0/hot_2.3.0_linux_arm64.tar.gz"
      sha256 "1f281da00031eb19e2e45138e3dc0536ce6c96260a199df080479ea397b39178"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.0/hot_2.3.0_linux_x86_64.tar.gz"
      sha256 "38691dc236d3642553caf7e7ffff973faa33c152f1cce737e72592922021beda"
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
