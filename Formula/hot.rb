class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.5.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.5.1/hot_2.5.1_macos_arm64.tar.gz"
      sha256 "667de89edc19aea1f4773c1c798d43f24cf4a472b75ab13281a5a6ceb5f8179a"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.5.1/hot_2.5.1_macos_x86_64.tar.gz"
      sha256 "bac906c1eeb7beab6a4f1337e42d806a5d19b18ce83dd798b6219ad0c7bdf321"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.5.1/hot_2.5.1_linux_arm64.tar.gz"
      sha256 "509a20e4faf8469a7a59166dfeb07a62a855bbfd8e63c1c20aa57c333ae85f09"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.5.1/hot_2.5.1_linux_x86_64.tar.gz"
      sha256 "7aa3e6251ceebb06c9f4d7bd3e6c40cb43ada58fc58c240cc1f1fd6144b8a9ff"
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
