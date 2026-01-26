class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.12"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.12/hot_1.0.12_macos_arm64.tar.gz"
      sha256 "7eb77fcace55199e16549146fcc7b8806ac8bdfd0c1f5f7b7e5b8bf8888a29c4"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.12/hot_1.0.12_macos_x86_64.tar.gz"
      sha256 "b2a29af2333889dce9604d1a7887751631859f73e9f51fb8da65ac1bc528699d"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.12/hot_1.0.12_linux_arm64.tar.gz"
      sha256 "d18105a547fc34a1a03018541620ed38d94351e803dec1e5e0089f74dc6f92d1"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.12/hot_1.0.12_linux_x86_64.tar.gz"
      sha256 "8d5547131875c7f2dcad2379d1cba40f5b3141667c2a496eb548b899353949c5"
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
