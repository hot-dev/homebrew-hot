class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.1/hot_3.0.1_macos_arm64.tar.gz"
      sha256 "cb7572138d1bbf22529e0b3dbdc23a24eea7a2235e5fb729d466f0e238e9e3fa"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.1/hot_3.0.1_macos_x86_64.tar.gz"
      sha256 "a7128cbc3993a0777ec4922ab3ca3d48a3c0882a80a45153dba7286cfdde584c"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.1/hot_3.0.1_linux_arm64.tar.gz"
      sha256 "d03ca4231e207c2c1062ff03be8cd3a727eb5f49db616e8f206dcd001bf4eb14"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.1/hot_3.0.1_linux_x86_64.tar.gz"
      sha256 "14ef0dddde09b064fa6323f79285076c2246cc0b8d1cbfa675a280d5bef25828"
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
