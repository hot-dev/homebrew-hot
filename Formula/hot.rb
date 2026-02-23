class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.1.4"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.1.4/hot_1.1.4_macos_arm64.tar.gz"
      sha256 "f4e9d6e4fe802f823f4aaf9133c17beb3bcff12f7051bbe91712c31cabb36af4"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.4/hot_1.1.4_macos_x86_64.tar.gz"
      sha256 "ae59a8f4e18f2f7ea3ab7e6883869791b7f8448e9742ac9f16d96f189103b986"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.1.4/hot_1.1.4_linux_arm64.tar.gz"
      sha256 "d8471f8aa7fe28fc0d01ff375de8a98ec69bbd5cc481bccd3372b68b07015605"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.1.4/hot_1.1.4_linux_x86_64.tar.gz"
      sha256 "301842ed565f259ca107a56ed7a6ddad902bc01b1e3de14dd2be30cec3eba65a"
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

    # Install AI resources (AGENTS.md and skills)
    (share/"hot/ai").install Dir["ai/*"]

    # Install init templates
    (share/"hot/init").install Dir["init/*"]

    # Install license file
    (share/"hot").install "LICENSE.md"

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
