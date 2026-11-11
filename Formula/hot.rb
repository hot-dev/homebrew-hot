class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "3.0.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/3.0.8/hot_3.0.8_macos_arm64.tar.gz"
      sha256 "9f2540691beba0b3fd42aa2fe4480b6c7d632aed1153bd0580102036c1c16320"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.8/hot_3.0.8_macos_x86_64.tar.gz"
      sha256 "766e772c1b260cd1d9ee2948db12127c8200ebc73c267bab585c53531a407ddc"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/3.0.8/hot_3.0.8_linux_arm64.tar.gz"
      sha256 "b297b23a9f0f58c2cb8bd829a8ae685d1df47ba005873868f195a62477772e02"
    end
    on_intel do
      url "https://get.hot.dev/releases/3.0.8/hot_3.0.8_linux_x86_64.tar.gz"
      sha256 "46e4c390a4e61fe1e464b51470ddb8dc46513aaaab964044038a2affece8d219"
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
