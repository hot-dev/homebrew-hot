class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.6"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.6/hot_1.2.6_macos_arm64.tar.gz"
      sha256 "4006b3679ee2543330fc65c71df82aa3e4dd6847734d4901bb9cd5a828127efb"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.6/hot_1.2.6_macos_x86_64.tar.gz"
      sha256 "23219e9f404ab50b2d0f81d07e661a3f9f6655bef26e75532a553d255a85b894"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.6/hot_1.2.6_linux_arm64.tar.gz"
      sha256 "33e809968802e5de1fa7596e4bcc52ef12cf18f996d2f2dca281ebeb1ff4e681"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.6/hot_1.2.6_linux_x86_64.tar.gz"
      sha256 "e02bd7b62c8ba99b4c6fb5654d109391e81cd0cefff02358509835aa3ae66add"
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
