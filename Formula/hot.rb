class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.25"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.25/hot_1.0.25_macos_arm64.tar.gz"
      sha256 "1d5598f99ca22dd49d85eaf76ec0c7cfc2b772d5dc43b4199c081f908a650d64"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.25/hot_1.0.25_macos_x86_64.tar.gz"
      sha256 "a440c9ded234f0e320e0e768c245f399959e50c378c16140573dcc1dd39e399a"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.25/hot_1.0.25_linux_arm64.tar.gz"
      sha256 "f616f1ccd38deefbbbc6c0f4264e06f4b37915f9b86329e69be1106bd4edd8fe"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.25/hot_1.0.25_linux_x86_64.tar.gz"
      sha256 "b4cb63c73a03425df183b33ff68aae90ac8ad0f15af358b27eb153707b4f8ba5"
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
