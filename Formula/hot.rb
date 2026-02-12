class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.43"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.43/hot_1.0.43_macos_arm64.tar.gz"
      sha256 "124e9f087703ee7027d8bcfbe677c74d09931af1e658a199938f8717de328b02"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.43/hot_1.0.43_macos_x86_64.tar.gz"
      sha256 "be587f3c1a538451b9f99148fda41a3c253e078e52811fdec723df02b9a87409"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.43/hot_1.0.43_linux_arm64.tar.gz"
      sha256 "a5ecdf90a7cc0fd3896b3da1756682a36987eaf8032fdb994aefcec82d347ef4"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.43/hot_1.0.43_linux_x86_64.tar.gz"
      sha256 "4ca8c2873bdc46b80c115d9a66a47acc62819b1d9df41229725f075931ec7beb"
    end
  end

  def install
    bin.install "hot"

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
