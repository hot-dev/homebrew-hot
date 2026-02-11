class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.38"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.38/hot_1.0.38_macos_arm64.tar.gz"
      sha256 "713e5ab61b2757244f7a33b1a14ef14fdc6b6449af16d5b7c79c69ada04f2b29"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.38/hot_1.0.38_macos_x86_64.tar.gz"
      sha256 "a1f79bb8684c81c6cbbd21cbc83e536f39f7515373bd47ef3db4a81b767ffdf3"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.38/hot_1.0.38_linux_arm64.tar.gz"
      sha256 "ac85a8365aed738e408750a4fcd7434cba4d2f43d02e119265e0ef752a472bd2"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.38/hot_1.0.38_linux_x86_64.tar.gz"
      sha256 "9588ab61ee9e6a063ef1902d30315475b569c70e6ae45e6fb3dcec6075c65706"
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
