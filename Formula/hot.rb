class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "0.18.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/0.18.0/hot_0.18.0_macos_arm64.tar.gz"
      sha256 "03d1cd9d03741906bfe7d359080efe530628f72425e77a497f2ad26922024bc8"
    end
    on_intel do
      url "https://get.hot.dev/releases/0.18.0/hot_0.18.0_macos_x86_64.tar.gz"
      sha256 "8c1d7cc04711e961859ef97645f3ca167a79dfc8842947cee83dab00890ec0d9"
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
