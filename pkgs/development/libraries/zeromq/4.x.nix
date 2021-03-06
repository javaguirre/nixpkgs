{ stdenv, fetchurl, libuuid, pkgconfig, libsodium }:

stdenv.mkDerivation rec {
  name = "zeromq-4.1.3";

  src = fetchurl {
    url = "http://download.zeromq.org/${name}.tar.gz";
    sha256 = "04gligbgr0phipjkwc0dyk1vr9306r6s4dbj85z7fxxk1n1ircv1";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libuuid libsodium ];

  meta = with stdenv.lib; {
    branch = "4";
    homepage = "http://www.zeromq.org";
    description = "The Intelligent Transport Layer";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ wkennington ];
  };
}
