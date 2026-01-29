class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.18"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.18/hot_1.0.18_macos_arm64.tar.gz"
      sha256 "d8d6a47d152177f8db2597204c0dddd82cb6d4966348897eaf759e3dcb4bcbd8"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.18/hot_1.0.18_macos_x86_64.tar.gz"
      sha256 "935f1e6e7622bc1cc02cc68a1f229fc02955bbd5b5f2e5c2e49b38e7e017b95f"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.18/hot_1.0.18_linux_arm64.tar.gz"
      sha256 "f3ce67ff7bb3edb764b63e0a4c8fad420974022f942c30d715a1852c091112bc"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.18/hot_1.0.18_linux_x86_64.tar.gz"
      sha256 "8411ae61852bc8baeaa2e77ad58b5eb81c5f32019a4da559fb01ee08fbfbdcbe"
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
