class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.1.8"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.1.8/hot_1.1.8_macos_arm64.tar.gz"
      sha256 "40818482773f723ff593c8a0ad56e400258a3240c5cdf0d7699fdca37bc1da43"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.8/hot_1.1.8_macos_x86_64.tar.gz"
      sha256 "ab9936e0ff58654804189df135c3a4daaa8aed97e92f7eeb6f5f4ceb1e4c65c9"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.1.8/hot_1.1.8_linux_arm64.tar.gz"
      sha256 "483991e1359cd7c8251dcbdd2e60b071892fd0a97852573bb6a265b5a7302c12"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.8/hot_1.1.8_linux_x86_64.tar.gz"
      sha256 "40c3c351c95647827d72a5ea18cde56f1ac01807992cc4ee6b00616a51229fa5"
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
