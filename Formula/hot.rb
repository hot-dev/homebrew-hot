class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.44"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.44/hot_1.0.44_macos_arm64.tar.gz"
      sha256 "2d0dd85bd0516b686623d4b6a82cc1edf61f0f1636fb4c3fc3c00e2f8dbbb873"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.44/hot_1.0.44_macos_x86_64.tar.gz"
      sha256 "2b27396c4468a950041d9be206335819afe41bfe51e3fe8a15e64fb6d845f4f7"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.44/hot_1.0.44_linux_arm64.tar.gz"
      sha256 "b9e4964623aaa3fd7ba77e7d7dc59f1d92b381bdb88f7ed973f9d2e66fc68cb6"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.44/hot_1.0.44_linux_x86_64.tar.gz"
      sha256 "7578aab5815e502dbf943460a8c4cad49056bf0c7e4b686c1b8872b5f0324fff"
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
