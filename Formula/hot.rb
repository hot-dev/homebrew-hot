class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.4"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.4/hot_1.0.4_macos_arm64.tar.gz"
      sha256 "66229d6d1b0a3dcf88afc5d372821d8a273bbaf9aedbda7093fbf215acce262e"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.4/hot_1.0.4_macos_x86_64.tar.gz"
      sha256 "6f646ca49dfebd9a5e9a4e2527bd9666630959aaaf81f4f2ed7181cd9ce8f3ec"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.4/hot_1.0.4_linux_arm64.tar.gz"
      sha256 "2878f50f4c86c9cab144683abc9b2b9cf39d2323565db812ffe3a2c76105d4e7"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.4/hot_1.0.4_linux_x86_64.tar.gz"
      sha256 "4c7bf8e270ae9e534536d2f015fe8fc6b9d4f9e375fa4957cded49dbe4b31fa7"
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
