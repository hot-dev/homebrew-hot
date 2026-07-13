class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.1/hot_2.6.1_macos_arm64.tar.gz"
      sha256 "19b75a6269edd948050e9dd8b29d808dd86d49a536470a5b5018f05d80e3c923"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.1/hot_2.6.1_macos_x86_64.tar.gz"
      sha256 "8a4def2db99430a947489fa01f9c174d1a7d841a35f31bd99157ae08c0459cc6"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.1/hot_2.6.1_linux_arm64.tar.gz"
      sha256 "eb2a4cd4ac5028de5362515ddcbf2e6b41aed4c3debbc58151a64bf173acad0c"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.1/hot_2.6.1_linux_x86_64.tar.gz"
      sha256 "0e441dfa0d3dfa7caa1997c2e47c0485217c1167974f77ed02a766ef35230c87"
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
