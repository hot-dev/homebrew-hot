class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.0/hot_2.6.0_macos_arm64.tar.gz"
      sha256 "c1a1031df29ca3852134a27cecfc58f9954468d8f4227ccef9a3b3095bb7e247"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.0/hot_2.6.0_macos_x86_64.tar.gz"
      sha256 "e2c8f3714bea6fbb7a2de161d1257ef65fa9a22cae5431888dcc0ced5bb101e9"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.0/hot_2.6.0_linux_arm64.tar.gz"
      sha256 "0811c1693fdbd29e6564d766a86dc361fa23fc7c4002d45c0219f5fd10e6020b"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.0/hot_2.6.0_linux_x86_64.tar.gz"
      sha256 "e7c59ce1e68c5e2dcbfe74810a547a81af7e1f43fbb6df66ed1ab9aea0ab6d75"
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
