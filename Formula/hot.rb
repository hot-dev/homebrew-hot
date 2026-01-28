class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.15"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.15/hot_1.0.15_macos_arm64.tar.gz"
      sha256 "91d3357c5840537445e78119a4f1ea66b75987ffa154a153feb17605aec4619a"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.15/hot_1.0.15_macos_x86_64.tar.gz"
      sha256 "546ac2694456af351d66add40a8778bcbc2817e44062e460866c3e966b30f6ca"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.15/hot_1.0.15_linux_arm64.tar.gz"
      sha256 "62ce72bdc7b2758ab550ae70113ff238b990fc77067acdedad6976f89a7111bc"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.15/hot_1.0.15_linux_x86_64.tar.gz"
      sha256 "9edfe0ef9a3a05006385db37137e946ebca1f5886c778e1150905974881dbf49"
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
