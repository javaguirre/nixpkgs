{stdenv, fetchurl, libX11, libXinerama, patches ? []}:

let
  name = "dwm-6.0-javaguirre";
in
stdenv.mkDerivation {
  inherit name;

  src = fetchurl {
    url = "https://github.com/javaguirre/dwm/archive/master.tar.gz";
    sha256 = "0b6dk8z9czmcygaxgn75idqhgdzfv7bavb132lpvmya98af056n2";
  };

  buildInputs = [ libX11 libXinerama ];

  prePatch = ''sed -i "s@/usr/local@$out@" config.mk'';

  # Allow users set their own list of patches
  inherit patches;

  buildPhase = " make ";

  meta = {
    homepage = "www.suckless.org";
    description = "Dynamic window manager for X";
    license = stdenv.lib.licenses.mit;
    maintainers = with stdenv.lib.maintainers; [viric];
    platforms = with stdenv.lib.platforms; all;
  };
}
