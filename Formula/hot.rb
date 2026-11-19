class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.12"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.12/hot_3.0.12_macos_arm64.tar.gz"
      sha256 "3bbd4c2f1fd31d32a80cd5cc39e17191fc5c7604d5b83752db32da85d6b11563"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.12/hot_3.0.12_macos_x86_64.tar.gz"
      sha256 "a396a995ae63085b3745b94b299d70d16d7d583fe757ec2ccc82f963ee1c9e58"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.12/hot_3.0.12_linux_arm64.tar.gz"
      sha256 "6f6973c976470d71523e3cd6076009ec525097c8611f4faed3591cb9fb0137cc"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.12/hot_3.0.12_linux_x86_64.tar.gz"
      sha256 "2739fb9bb5d70204508fcad82d04e2b8f18c24de7d4c75c4bcb539cf3c2e35f8"
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
