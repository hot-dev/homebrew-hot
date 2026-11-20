class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.13"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.13/hot_3.0.13_macos_arm64.tar.gz"
      sha256 "d1d46311908fa6433c9d5f90b96da62f91a73293926d5fc3596c76d26dbd0869"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.13/hot_3.0.13_macos_x86_64.tar.gz"
      sha256 "5d595f9c833b3051faec11a5d391d0939afece14a2bce20f20355f5fb1a7ceac"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.13/hot_3.0.13_linux_arm64.tar.gz"
      sha256 "ad9f0a5a0de092a4f88394f573806b8ce32e36d6432fe45c7e0d343564bf00cd"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.13/hot_3.0.13_linux_x86_64.tar.gz"
      sha256 "6746255f0e4c9cdaee0c8287bfe8ac9252993d0df4f0c9e3b644e3914b06f614"
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
