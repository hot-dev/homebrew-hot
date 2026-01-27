class Hot < Formula
  desc "Hot programming language and runtime"
  homepage "https://hot.dev"
  version "1.0.14"
  license :cannot_represent  # Hot Dev Software License Agreement - https://hot.dev/license

  on_macos do
    on_arm do
      url "https://get.hot.dev/releases/1.0.14/hot_1.0.14_macos_arm64.tar.gz"
      sha256 "e452a4763d39da0ffc7049a76c0510303151a1bd4404483d0764ab8bf1a16ea5"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.14/hot_1.0.14_macos_x86_64.tar.gz"
      sha256 "a54ad0f934662097441755b21fc6f5aa4e8e3b83f20b568430048fcccff90b3a"
    end
  end

  on_linux do
    on_arm do
      url "https://get.hot.dev/releases/1.0.14/hot_1.0.14_linux_arm64.tar.gz"
      sha256 "758e8e69350f73e478f4a3eeaf3fc3bbb9693ecf8c2729eca44023978048faf3"
    end
    on_intel do
      url "https://get.hot.dev/releases/1.0.14/hot_1.0.14_linux_x86_64.tar.gz"
      sha256 "cbe1c251414e768753935aebd6e22963a049cdd0a24356b4da25db6290329f78"
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
