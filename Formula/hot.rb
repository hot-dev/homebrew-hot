class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.20"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.20/hot_1.0.20_macos_arm64.tar.gz"
      sha256 "ecb35ac7600b3c9325bd05828bf24a21b645e4927c0eb4192403070f3b57e147"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.20/hot_1.0.20_macos_x86_64.tar.gz"
      sha256 "9ecc823a056bba0955117c034dc70d1052f3da9e2fe84297033519c3f1a69a26"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.20/hot_1.0.20_linux_arm64.tar.gz"
      sha256 "591e448039ce73061c9ca317b071175ef4f87bc804b820be36bd98db4b8aea95"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.20/hot_1.0.20_linux_x86_64.tar.gz"
      sha256 "2906874f27790b3bcefb48b0ae1b4f77d1ab9e2fdbca9c447574dc31818544e1"
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
