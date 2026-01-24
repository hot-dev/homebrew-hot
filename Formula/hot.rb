class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.9"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.9/hot_1.0.9_macos_arm64.tar.gz"
      sha256 "3f85adcc1b9c32ee4a5fb6b94ec4fce96587b427df891578bcfb1157f423953b"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.9/hot_1.0.9_macos_x86_64.tar.gz"
      sha256 "09ff0a98f6f0c79f9f3e78b490dda96c48915d7ee68874464f1f9766694eed71"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.9/hot_1.0.9_linux_arm64.tar.gz"
      sha256 "df49e56137418db23a186cf8eca42f37f35845b6aae038be9773f8c7cddaa56e"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.9/hot_1.0.9_linux_x86_64.tar.gz"
      sha256 "ad239b074e3e1bfce4f0df90558d7febea3517d393d064ab783ed363496cd348"
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
