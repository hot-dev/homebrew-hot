class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.4.0/hot_2.4.0_macos_arm64.tar.gz"
      sha256 "9f83e4d51e1b007b5cff0d6b3f6c42369be658b4513aeb0e4f970d0b07252e7f"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.0/hot_2.4.0_macos_x86_64.tar.gz"
      sha256 "d4bbbb2bf7013c4410407465eb07f6c5c040bd5432c36ab293cd2ed5513dc838"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.4.0/hot_2.4.0_linux_arm64.tar.gz"
      sha256 "11c30ae967d3dbf83709adc3c7bddc8f627bf7e08db04cb405c01a6badbac834"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.4.0/hot_2.4.0_linux_x86_64.tar.gz"
      sha256 "c087c6d823ab15d5f9302a9edc068e8d839d60c56271c153cc8dc0416e535613"
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
