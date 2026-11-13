class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.9/hot_3.0.9_macos_arm64.tar.gz"
      sha256 "8c0a719f33c884b8185ce4f47433a70f80461dcbdeaf62c330e697918b3fef37"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.9/hot_3.0.9_macos_x86_64.tar.gz"
      sha256 "1c678bf83ea76e4cf855ed692d72ee65ba5c57103b595fb997ba61344a8d16ce"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.9/hot_3.0.9_linux_arm64.tar.gz"
      sha256 "b61bbd47bcd779dfd6e770c82cf33725851d1223195fa1c0c01428d53637fe46"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.9/hot_3.0.9_linux_x86_64.tar.gz"
      sha256 "80ced0dbdbf402edfc8f67ed7743d203858a2851c0531cea29ace42cf90c52ec"
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
