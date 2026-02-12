class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.45"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.45/hot_1.0.45_macos_arm64.tar.gz"
      sha256 "3dea17e6d542d584f69e2ecaa881558cd575c71fa4d5625cdd4f0b5897b3c099"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.45/hot_1.0.45_macos_x86_64.tar.gz"
      sha256 "521131f535e399445f07b581098425f9ba833bde8ac6887d5d7f75e0cc33e82a"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.45/hot_1.0.45_linux_arm64.tar.gz"
      sha256 "6c2a28e0de779415814678e5c50fda862d0c4fd1b41b200caffd5f8d7a24f25b"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.45/hot_1.0.45_linux_x86_64.tar.gz"
      sha256 "1735296da2a63cff01a1b29d11d677dec2d8eec88951cd7c2f76724680cab79f"
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
