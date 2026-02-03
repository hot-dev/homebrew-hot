class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.26"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.26/hot_1.0.26_macos_arm64.tar.gz"
      sha256 "8b5111a2ff900f454f4cbcba74e5758c641287417f652bb54cb7beea1da8707c"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.26/hot_1.0.26_macos_x86_64.tar.gz"
      sha256 "4aa51fc244eb09599a754275d9de545a43eed9381e8715e110268c1b9a887b76"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.26/hot_1.0.26_linux_arm64.tar.gz"
      sha256 "2411636fcd811bd8b26e8aed9af7b3ea7e6025e14bd656947079c6bcb901639a"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.26/hot_1.0.26_linux_x86_64.tar.gz"
      sha256 "856104d2077f7e83feaa13af0b7622d40a59d2dee64aa3cfa83c94097f99528f"
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
