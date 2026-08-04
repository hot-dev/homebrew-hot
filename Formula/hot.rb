class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.8/hot_2.6.8_macos_arm64.tar.gz"
      sha256 "743aa53b1569c999c0630119fdbe73b65212ede8fc20c19c7d932bab532ac73b"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.8/hot_2.6.8_macos_x86_64.tar.gz"
      sha256 "926459a9f919ba4844937d337b800fef679af5db371a8ae2c4584ae0158c95ae"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.8/hot_2.6.8_linux_arm64.tar.gz"
      sha256 "8c4925b989701a6ab75be8cc66928088138a0faf46878b4cc7b2471c3d25c21c"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.8/hot_2.6.8_linux_x86_64.tar.gz"
      sha256 "362b75a3a256f407a95c9ec07a0270cd98530caec53166a26ff26cefa34cf02b"
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
