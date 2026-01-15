class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.5"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.5/hot_1.0.5_macos_arm64.tar.gz"
      sha256 "57d3ee36a98300662926c5830ad741e3bc7ce2998f085f61969f4f96e4bcfebb"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.5/hot_1.0.5_macos_x86_64.tar.gz"
      sha256 "103612c24a14f3f57a798bef3fd563f74c7eafe6c0b48fb3d454e7f8b8c88e18"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.5/hot_1.0.5_linux_arm64.tar.gz"
      sha256 "a3f384147e9193c100fd912d841b91d9a753f5c4846fedb1b9cf50c1035aaca7"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.5/hot_1.0.5_linux_x86_64.tar.gz"
      sha256 "2290dd439170814c52a6e1b2eb7ac023ea5755e36379f1232a76d9ca65ae1a8a"
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
