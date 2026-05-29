class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.1.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.1.2/hot_2.1.2_macos_arm64.tar.gz"
      sha256 "1f423464d72b4d2beed8529f2a5728b7516960b01b481048e81dcd3b0b82daef"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.1.2/hot_2.1.2_macos_x86_64.tar.gz"
      sha256 "5d42d1a641a5c8c5502f6b3d85d93889759863f2666d107a4e070a88f8eab605"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.1.2/hot_2.1.2_linux_arm64.tar.gz"
      sha256 "e0aeec39c066c275af25f63d48b26cf2e74a738e797a8a40c9c45739c84f6bed"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.1.2/hot_2.1.2_linux_x86_64.tar.gz"
      sha256 "786aaf5d43137730f1dab71307a3f3aad5072c7470b1e2d81028ece50aee5c50"
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
