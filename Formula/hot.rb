class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.2.3"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_macos_arm64.tar.gz"
      sha256 "becceb33df24d133ea1de61d6d90e63e17b69082be8d9793ccc3b6fda63c4dfb"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_macos_x86_64.tar.gz"
      sha256 "5f2e3291bfd3bb66751be8cac68d6bc73f07234ec10f7997c3eeef64cb9c787b"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_linux_arm64.tar.gz"
      sha256 "2e53255da6a8a937cdb66390c3c097281b190b1b51e6760c94196a2bc1c39dda"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.2.3/hot_1.2.3_linux_x86_64.tar.gz"
      sha256 "346162b0e1bb1f9b6401e11a04729f79d3e516d5cca5c647c0949bc0fbf7056a"
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
