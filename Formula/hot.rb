class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.15"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.15/hot_3.0.15_macos_arm64.tar.gz"
      sha256 "2b607076ff9bb78fb62b7d557f0efea43485896d9ad7691fa1fa72c46f16ca25"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.15/hot_3.0.15_macos_x86_64.tar.gz"
      sha256 "a97b758b77703b97cadbd12d11f6a878588b730e6f1472d89282e87f02166c76"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.15/hot_3.0.15_linux_arm64.tar.gz"
      sha256 "6b81958152c520514788e65c470c61f86a9e323639e16504f30f3dbec222dacf"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.15/hot_3.0.15_linux_x86_64.tar.gz"
      sha256 "278f42681e24b6db49747fd9c03ba5574eb8348c36d430c7df42a80efe95bc66"
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
