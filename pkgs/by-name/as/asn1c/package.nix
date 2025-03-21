{
  lib,
  stdenv,
  fetchurl,
  perl,
}:

stdenv.mkDerivation rec {
  pname = "asn1c";
  version = "0.9.28";

  src = fetchurl {
    url = "https://lionet.info/soft/asn1c-${version}.tar.gz";
    sha256 = "1fc64g45ykmv73kdndr4zdm4wxhimhrir4rxnygxvwkych5l81w0";
  };

  outputs = [
    "out"
    "doc"
    "man"
  ];

  buildInputs = [ perl ];

  preConfigure = ''
    patchShebangs examples/crfc2asn1.pl
  '';

  postInstall = ''
    cp -r skeletons/standard-modules $out/share/asn1c
  '';

  doCheck = true;

  meta = with lib; {
    homepage = "http://lionet.info/asn1c/compiler.html";
    description = "Open Source ASN.1 Compiler";
    license = licenses.bsd2;
    platforms = platforms.unix;
    maintainers = [ maintainers.numinit ];
  };
}
