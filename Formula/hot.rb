class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.1.5"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.1.5/hot_1.1.5_macos_arm64.tar.gz"
      sha256 "db55591e8233eaa9db6327aca416c2648eee7dbb48a2381ca09191a2be672a6a"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.5/hot_1.1.5_macos_x86_64.tar.gz"
      sha256 "8005e99e2274e1b25676da8f54c14c229b3cb980b33fb5861945c4a95a924542"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.1.5/hot_1.1.5_linux_arm64.tar.gz"
      sha256 "274dcd09789d1752263bafd457e78243f8c2ef70f23e5e249bed963675272f14"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.5/hot_1.1.5_linux_x86_64.tar.gz"
      sha256 "b3728383ee79198c2de0055b6c52c305182d1cb115b4713c0606e6bd98ec3bf9"
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
