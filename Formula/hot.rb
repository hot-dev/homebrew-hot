class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.47"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.47/hot_1.0.47_macos_arm64.tar.gz"
      sha256 "80bd1ce06d4db3d5fcb060b5bb8d308c6c22f29472907778cb100a1ab675d53d"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.47/hot_1.0.47_macos_x86_64.tar.gz"
      sha256 "f90ebd8b5ad5b51f3b22e8be792d9992be45a9ebcdc9e865777d582293a1f81c"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.47/hot_1.0.47_linux_arm64.tar.gz"
      sha256 "94d352423a35002dcb3079d965adc2fb06858299421d865774c7d90b6c1b87f4"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.47/hot_1.0.47_linux_x86_64.tar.gz"
      sha256 "742ca3358cd517370910b7c6866fa94642331c3fd96559086223a8c52de0bb1c"
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
