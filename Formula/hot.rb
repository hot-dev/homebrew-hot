class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.39"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.39/hot_1.0.39_macos_arm64.tar.gz"
      sha256 "24f664a1db2b196245b1b215cf46e5a8594b6364c4bb7b0656a2e3c5259207d3"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.39/hot_1.0.39_macos_x86_64.tar.gz"
      sha256 "349a19f48ed592516135302e6e76a7d4496820bbd797c1dd95a57f9040ce9af5"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.39/hot_1.0.39_linux_arm64.tar.gz"
      sha256 "05e8e130e59f7f257b7334e1bb5a58c8111d9024f570f575142817ae679839d5"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.39/hot_1.0.39_linux_x86_64.tar.gz"
      sha256 "da1917aea016b230d49c67855877713e9dea03730d5a4389f3c95b50bfc2adef"
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
