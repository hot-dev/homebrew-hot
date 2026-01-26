class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.11"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.11/hot_1.0.11_macos_arm64.tar.gz"
      sha256 "26ca43224b9aa3808cb3d158da46be7d4099e193889517fa36f77fde3307c0e7"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.11/hot_1.0.11_macos_x86_64.tar.gz"
      sha256 "17db9ea23ee1bc6e49d3b0c98e82dcf4bed4696a9491cfe23393df7853e0b6e8"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.11/hot_1.0.11_linux_arm64.tar.gz"
      sha256 "44f65382b3567dba9d9fb020574d6f605c7ef66bb95acbbba5d5ac3fe7617997"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.11/hot_1.0.11_linux_x86_64.tar.gz"
      sha256 "18720956efcbf3f8dec5b5f08efe0c485ba273e342035237a186e49627693150"
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
