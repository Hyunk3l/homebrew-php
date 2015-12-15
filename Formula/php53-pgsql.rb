require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pgsql < AbstractPhp53Extension
  init
  desc "A unified PostgreSQL driver for PHP"
  homepage "https://github.com/php/php-src/tree/master/ext/pgsql"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "postgresql"

  def extension
    "pgsql"
  end

  def install
    Dir.chdir "ext/pdo_pgsql"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-pgsql=#{Formula["postgresql"].prefix}", phpconfig
    system "make"
    prefix.install "modules/pgsql.so"
    write_config_file if build.with? "config-file"
  end
end
