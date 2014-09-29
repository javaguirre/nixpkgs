{ stdenv, fetchurl, pkgconfig, writeText, libX11, ncurses, libXext, libXft, fontconfig
, conf? null}:

with stdenv.lib;

stdenv.mkDerivation rec {
  name = "st-0.4.1-javaguirre";

  src = fetchurl {
    url = "https://github.com/javaguirre/st/archive/master.tar.gz";
    sha256 = "1c89nff0gqvqpaaqf5610c4vskwds1nznfgixighj2y6mbfsznfz";
  };

  configFile = optionalString (conf!=null) (writeText "config.def.h" conf);
  preBuild = optionalString (conf!=null) "cp ${configFile} config.def.h";

  buildInputs = [ pkgconfig libX11 ncurses libXext libXft fontconfig ];

  NIX_LDFLAGS = "-lfontconfig";

  installPhase = ''
    TERMINFO=$out/share/terminfo make install PREFIX=$out
  '';

  meta = {
    homepage = http://st.suckless.org/;
    license = stdenv.lib.licenses.mit;
    maintainers = with maintainers; [viric];
    platforms = with platforms; linux;
  };
}
