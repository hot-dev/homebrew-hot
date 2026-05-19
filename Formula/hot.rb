class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.0.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.0.4/hot_2.0.4_macos_arm64.tar.gz"
      sha256 "ef5f3939103a3832ef6d23d47429c915340bc7c6eca1d74e42fc1d5a6c7e3fa6"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.4/hot_2.0.4_macos_x86_64.tar.gz"
      sha256 "2da09b3d69edd4475b3331db9c78bbb2c75392df57ad24be2b9e92d2b1001302"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.0.4/hot_2.0.4_linux_arm64.tar.gz"
      sha256 "4e73c58fc6b293a445ac057cba453f8c7e967815229c1a4a9169a0c806da9240"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.0.4/hot_2.0.4_linux_x86_64.tar.gz"
      sha256 "119016d1130387eded69cb795369c3a429b966a9ddef8c0a1b91eb0328769f77"
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
