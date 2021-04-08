class Uuu < Formula
  desc "uuu (universal update utility) for nxp imx chips"
  homepage "https://github.com/NXPmicro/mfgtools"
  license "BSD 3-Clause \"New\" or \"Revised\" License"

  head do
    url "https://github.com/NXPmicro/mfgtools.git", :shallow => false

    depends_on "cmake" => :build
    depends_on "pkg-config" => :build
    depends_on "tig" => :build

    patch :DATA
  end

  depends_on "libusb"
  depends_on "libzip"
  depends_on "openssl"


  def install
    system "git", "fetch", "--tags", "--prune", "--no-recurse-submodules"
    cmake_args = std_cmake_args
    cmake_args << "-DOPENSSL_ROOT_DIR=#{HOMEBREW_PREFIX}/opt/openssl"
    system "cmake", ".", *cmake_args
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
--- a/libuuu/buffer.cpp
+++ b/libuuu/buffer.cpp
@@ -52,6 +52,10 @@
 #include "dirent.h"
 #endif

+#ifdef __APPLE__
+#define stat64 stat
+#endif
+
 static map<string, shared_ptr<FileBuffer>> g_filebuffer_map;
 static mutex g_mutex_map;
