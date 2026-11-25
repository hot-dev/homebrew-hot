class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.16"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.16/hot_3.0.16_macos_arm64.tar.gz"
      sha256 "cdafc977082b9633f392969f3118a0142a687ba5ef5342e9293fa8df0615a85b"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.16/hot_3.0.16_macos_x86_64.tar.gz"
      sha256 "994f68833147f98aff3abb753d78d1011ff19e4beaba5ed3644661f8fa9d50dd"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.16/hot_3.0.16_linux_arm64.tar.gz"
      sha256 "dc08efe12805dcb4dbe98f5c81ab1564946151d9ac707bcc169027d49cccc81f"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.16/hot_3.0.16_linux_x86_64.tar.gz"
      sha256 "c7a0ea6fd2d604411241c57bdd3f12cb68073d15b6684c8aafee67d0c38fddac"
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
