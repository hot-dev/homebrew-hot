class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "2.6.11"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/2.6.11/hot_2.6.11_macos_arm64.tar.gz"
      sha256 "cb8100125be9e77f0636542254640cae842254405dee3ab9b58e36873261a24d"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.11/hot_2.6.11_macos_x86_64.tar.gz"
      sha256 "ff958709563efadcead49b964042f93349c65d8e7887fde765bb6740ef3ae111"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/2.6.11/hot_2.6.11_linux_arm64.tar.gz"
      sha256 "f8682ef19aab18dd7fa93fa6f7fe5b88cc929828ea8c790ed695ed694485ac43"
    end
    on_intel do
      url "https://get.hot.dev/releases/2.6.11/hot_2.6.11_linux_x86_64.tar.gz"
      sha256 "10a9e34790c2450ea2c7ee2d9a93464016dff9110c8ec22d1e2ca02d70a9202b"
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
