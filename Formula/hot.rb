class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.16"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.16/hot_1.0.16_macos_arm64.tar.gz"
      sha256 "11b241087f2180978174b7633b40aad41e481844401733ce6b2bd6a8801296a6"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.16/hot_1.0.16_macos_x86_64.tar.gz"
      sha256 "380c36c24190ec1faa252aff69146c30e266e3760c4222b1da526e51815bdee7"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.16/hot_1.0.16_linux_arm64.tar.gz"
      sha256 "ebcdf88feea84aa3a92a36e23aa448c5899b8babf2f13e20e416242287419068"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.16/hot_1.0.16_linux_x86_64.tar.gz"
      sha256 "5bb45a972fa0704d2c01c4c2cc05a815c38653887bf82cb8d0c300dca4c3c991"
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
