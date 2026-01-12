class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "0.17.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/0.17.0/hot_0.17.0_macos_arm64.tar.gz"
      sha256 "08e70cbfd7ef308465f74250936724c27e3ed1ad1297e87f50284c8e6d0e5741"
    end
    on_intel do
      url "https://get.hot.dev/releases/0.17.0/hot_0.17.0_macos_x86_64.tar.gz"
      sha256 "d4c04625c0d5e0fba82ec2274673443da4ecd6a4b6a12d3c820a4a53ee19f7f7"
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
