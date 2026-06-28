class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.6/hot_2.4.6_macos_arm64.tar.gz"
      sha256 "bcf2019c099428e21947eeb884b5af840561824d3b3ebefae3003b74afd5e4ac"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.6/hot_2.4.6_macos_x86_64.tar.gz"
      sha256 "980b4b55e2bb39f1c919d8b85cfc51d6b18837aaffd009f724b948dbc4bd745a"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.6/hot_2.4.6_linux_arm64.tar.gz"
      sha256 "08263c48711a3ef32e58a197ea8edf92098a9f0be70bc67a424f095f13c023e6"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.6/hot_2.4.6_linux_x86_64.tar.gz"
      sha256 "f2f9fadf0cddc8dee264258401e45a9073fa0b789660f00d6d0fb1b120541a1d"
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
