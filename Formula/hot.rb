class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "0.14.0"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/0.14.0/hot_0.14.0_macos_arm64.tar.gz"
      sha256 "d8ab3e77b57e242af514ea2f037bf0439559bb4990edef87799014760f2b1429"
    end
    on_intel do
      url "https://get.hot.dev/releases/0.14.0/hot_0.14.0_macos_x86_64.tar.gz"
      sha256 "eb9ec63deb1ce56e90898e98c76d524597db710b1fba834fa4ab4e7197453632"
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
