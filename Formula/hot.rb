class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.37"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.37/hot_1.0.37_macos_arm64.tar.gz"
      sha256 "8f6fd53e514a816a6a03358231945b4c924f30be594cede2c1e7b5f3d18e17bf"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.37/hot_1.0.37_macos_x86_64.tar.gz"
      sha256 "3957dd32c3e7dcbff4ca831ad4a131d9b38cefe525bb72fb0061ecc5244e1961"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.37/hot_1.0.37_linux_arm64.tar.gz"
      sha256 "a5ed517102e8951e66f5fbad0a8cf0742360187a7e712d7b9c4d3d92601551c6"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.37/hot_1.0.37_linux_x86_64.tar.gz"
      sha256 "f3e727e2458ca0717688f203a661723a7e899035e34129f6d2112122b01c5553"
    end
  end

  def install
    bin.install "hot"

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

    # Install license file
    (share/"hot").install "LICENSE.md"

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
