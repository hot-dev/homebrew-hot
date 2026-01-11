class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "0.15.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/0.15.0/hot_0.15.0_macos_arm64.tar.gz"
      sha256 "4e4c1ecb5b91b0038bb13375826e6d8988dc9da3789a5ae17647cae0d9ffcf72"
    end
    on_intel do
      url "https://get.hot.dev/releases/0.15.0/hot_0.15.0_macos_x86_64.tar.gz"
      sha256 "5bb3332ca4e8963ad0ad879359777d376c0a53e2e3f68df6fd21d6ed051cdd8c"
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
