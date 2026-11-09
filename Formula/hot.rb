class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.7/hot_3.0.7_macos_arm64.tar.gz"
      sha256 "99c576fba15d220c3c0a61fc6c10021c02e0e7413c74f621c3958a5db8ab3437"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.7/hot_3.0.7_macos_x86_64.tar.gz"
      sha256 "9fc88697b50b62b1922791bf04778482fe79968a0b78f7d660047738f0fe5685"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.7/hot_3.0.7_linux_arm64.tar.gz"
      sha256 "c796ece8fe7f716e71f07c2b036d27269ae4a8361a48e528974c1e7315893388"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.7/hot_3.0.7_linux_x86_64.tar.gz"
      sha256 "9eb8dbfff6356dc25792c474dba7800af9dffd97fb438242931e8da663504396"
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
