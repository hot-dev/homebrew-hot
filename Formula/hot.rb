class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.3.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.3.7/hot_2.3.7_macos_arm64.tar.gz"
      sha256 "d60dcb6fbab3785b8c42df274d7fac5052c30978027c84e29102bc7f24f954ca"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.7/hot_2.3.7_macos_x86_64.tar.gz"
      sha256 "8c0dd80f5029262ecb0a5d40172695e341325a310b0c9566adf587f1aec8ff1a"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.3.7/hot_2.3.7_linux_arm64.tar.gz"
      sha256 "e702b2ef847a00be630d06ca80446fe95c930e6beb05962936e092615da727fb"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.3.7/hot_2.3.7_linux_x86_64.tar.gz"
      sha256 "0f1811a1bd8ab3d1b4bc4fee0f3e4e478bd93d464877986db4cebd91a3a65a23"
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
