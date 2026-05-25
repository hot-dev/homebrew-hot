class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.9/hot_2.0.9_macos_arm64.tar.gz"
      sha256 "dce93a71bc5394bc40588815eae741d1c36ebf34c8246fc26c9792d0dd3807f5"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.9/hot_2.0.9_macos_x86_64.tar.gz"
      sha256 "817a87047d0301d6d9194da3b9dd5cd40bf1a46b1e089d2763836f4eb2d1ee6e"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.9/hot_2.0.9_linux_arm64.tar.gz"
      sha256 "51f62edb153c8ef67e335e59931747a42f5291d503cd4fe4e3b9102979435efd"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.9/hot_2.0.9_linux_x86_64.tar.gz"
      sha256 "176b5931876889c97af01d6b3152519e4b8dd8acabbe7f8ac5547a2160ddb457"
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
