class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.10"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.10/hot_1.0.10_macos_arm64.tar.gz"
      sha256 "3b093cd7012ea058af6edef51ac454bf493f59ab61f10985f15ca4feedea50ef"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.10/hot_1.0.10_macos_x86_64.tar.gz"
      sha256 "6e31ba8a488b42922b356cc31bc7ae2629750cafc0267d98250d43c77e5bb64f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.10/hot_1.0.10_linux_arm64.tar.gz"
      sha256 "bda1eca99c58cbbe4d0a1531da4ae938a87f8f82ec3e4bff8510fb16f0d9cc4a"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.10/hot_1.0.10_linux_x86_64.tar.gz"
      sha256 "c9e28ac1476cf5db9e21054e8a4720456412a8f58a6f238779cd169398e98e1a"
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
