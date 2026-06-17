class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.3.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.3.6/hot_2.3.6_macos_arm64.tar.gz"
      sha256 "fd10ce8dd09ecce688063dcd520135edf981879b54efe5ba3142c63f3994eebc"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.6/hot_2.3.6_macos_x86_64.tar.gz"
      sha256 "48f2351606110d21eb27cd2be8e48b51f0abf46275098cd3dbd5fbde28f1121b"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.3.6/hot_2.3.6_linux_arm64.tar.gz"
      sha256 "af931646bbac04f044762efdbfa62920dae324b0c15bb7e9a79703472b2d8fe7"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.6/hot_2.3.6_linux_x86_64.tar.gz"
      sha256 "d89eb9dfeeefdb54ec67d3d2d50422a25d29b01d9109a9bd024d996249fa9f54"
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
