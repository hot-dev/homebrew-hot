class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.7/hot_2.6.7_macos_arm64.tar.gz"
      sha256 "2dccce1f34fcc76cc2781d4f8f40580ed4cfab03a6fc33cacb548e61615c1c60"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.7/hot_2.6.7_macos_x86_64.tar.gz"
      sha256 "c09a5b87a723c04b9f113da2a25f833d1fe5098d921089c9273d1261469eb8bf"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.7/hot_2.6.7_linux_arm64.tar.gz"
      sha256 "243057cee4163df68538457f01398941008f612ab5dacef9a112f1d8640dc55a"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.7/hot_2.6.7_linux_x86_64.tar.gz"
      sha256 "bca9cb18c845b89ec5915f58161657c7af0d29ca8ce8058efbf8ee36e360fa10"
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
