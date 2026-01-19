class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.8"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.8/hot_1.0.8_macos_arm64.tar.gz"
      sha256 "e4cf415b684d6c69b91c5eccc3eab704b4f3d987b4435332fd46d9de6a6ce2ac"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.8/hot_1.0.8_macos_x86_64.tar.gz"
      sha256 "3d6dea72aed7939a95e08990eab84622f90cc7c7db78a163a157fb698d3b3364"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.8/hot_1.0.8_linux_arm64.tar.gz"
      sha256 "520585e286d67db892cf992f1c7ad277dbcd1cf7a771fb571cd9af914a1ddce0"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.8/hot_1.0.8_linux_x86_64.tar.gz"
      sha256 "a5b0339027032dda65f52162a37363756abb5d64337158abc135c22960ef73ac"
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
