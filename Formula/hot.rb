class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.3.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.3.1/hot_2.3.1_macos_arm64.tar.gz"
      sha256 "a8a5c3b4e5fc0feef681e61d661c2c56eb7a83da467f2ce7f0a8118ea583dcde"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.1/hot_2.3.1_macos_x86_64.tar.gz"
      sha256 "fa9c5d0eb15d893e5bacfdb9b0c0b3435a63aac68ef851cd4cddb31729c49abd"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.3.1/hot_2.3.1_linux_arm64.tar.gz"
      sha256 "e5c9823700529b0f4154c6b6b42dbdd857b480a4ac6235128a29ef1dfed251ed"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.1/hot_2.3.1_linux_x86_64.tar.gz"
      sha256 "0c0e3b54a3db255d5c3eafe3259a5316b88195aae503a81374669e7c48056065"
    end
  end

  def install
    bin.install "hot"

    # Install hotbox Linux binaries (for container tasks via hot dev)
    (share/"hot/bin").install Dir["bin/hotbox-*"]

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

    # Install license and notice files
    (share/"hot").install "LICENSE"
    (share/"hot").install "NOTICE"

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
