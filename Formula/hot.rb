class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.28"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.28/hot_1.0.28_macos_arm64.tar.gz"
      sha256 "3ef4ffba6f80e43629a45c0e5c77c811e2349877b56d8fa469e97e665d170c50"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.28/hot_1.0.28_macos_x86_64.tar.gz"
      sha256 "e62a70d37fc6b542adf2033ab2871707e75667faa8adb51ddba96ff112806260"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.28/hot_1.0.28_linux_arm64.tar.gz"
      sha256 "2c49025d48ad58d6942117082363883710c44e38ceaa2c228d010ddecdfada55"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.28/hot_1.0.28_linux_x86_64.tar.gz"
      sha256 "f6a82678eba7e2330d62bdb3661af6d87976d63f9b23b073a1640a59da0e9ad7"
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
