class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.4/hot_2.4.4_macos_arm64.tar.gz"
      sha256 "554f64992456d89fb34e6b3bace955c3764c3493e7191ab36af708ee083109c2"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.4/hot_2.4.4_macos_x86_64.tar.gz"
      sha256 "c597e11179dbdbb85649b5e671adc016e3480f4c89159c6fae938589c970db58"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.4/hot_2.4.4_linux_arm64.tar.gz"
      sha256 "691ca63d2c43513b0583cefe43c8787c940e982c9237c7e7c12752b6b26ec0f9"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.4/hot_2.4.4_linux_x86_64.tar.gz"
      sha256 "4a3911e8673d737af77b5e95e899b729e03304b8c5a6e1c1615be37f7c1de074"
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
