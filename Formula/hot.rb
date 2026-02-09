class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.34"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.34/hot_1.0.34_macos_arm64.tar.gz"
      sha256 "b9ac7eb57bb3c80e0d93414ddf9495d31b5fcbae01dc75befe588f013c6632e9"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.34/hot_1.0.34_macos_x86_64.tar.gz"
      sha256 "416cb9eac021bdfec77c573a561003cfc191ee5914e8dee7c5709b4af6b6e201"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.34/hot_1.0.34_linux_arm64.tar.gz"
      sha256 "da3e9d09d72b4e79146a27b3f05aa05afbee1fe3ba2afb98ce894d7e27b94d5f"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.34/hot_1.0.34_linux_x86_64.tar.gz"
      sha256 "c8ebc445a91d176a4ebd61311f628f651e428c20c9ef99f48207a181d362cefb"
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
