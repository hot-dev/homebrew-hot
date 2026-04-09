class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.1"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.1/hot_1.2.1_macos_arm64.tar.gz"
      sha256 "73b3de45717f02c3b1ca0f9387ef0e9d2266c7e9cd0bd49d4ba03f4d5b3d8bcb"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.1/hot_1.2.1_macos_x86_64.tar.gz"
      sha256 "dacade4278d0bb1ae9527d48ef25069bdd4451621bec0f33a3d3501a6fb71294"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.1/hot_1.2.1_linux_arm64.tar.gz"
      sha256 "c14d1836becfe2e8942eee8deccc88db86542ab131485fdba7748475adf42f0d"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.1/hot_1.2.1_linux_x86_64.tar.gz"
      sha256 "962d6f83999d94f34745884a39ca336c5aa84e364c00489d1f88eed8091bda70"
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

    # Install license file
    (share/"hot").install "LICENSE.md"

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
