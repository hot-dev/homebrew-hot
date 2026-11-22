class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.14"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.14/hot_3.0.14_macos_arm64.tar.gz"
      sha256 "b5b379602cc51fda2b539414b644e80664f85a8fade17581aa5696f4e57e1b28"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.14/hot_3.0.14_macos_x86_64.tar.gz"
      sha256 "cb4c84341a2bf48fa72b7a2b71b5c4ccc0df8f0ecd7a78af49a20f7a18103640"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.14/hot_3.0.14_linux_arm64.tar.gz"
      sha256 "b22f0eda48a219bc8654dcc0a4b788945fb9be0ee72e7fd5a0297a73a185a02e"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.14/hot_3.0.14_linux_x86_64.tar.gz"
      sha256 "a61451bbf790eea431810f9448a581eaa30e46e6b13be20238d280174b2e7fe3"
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
