{
  lib,
  stdenv,
  fetchFromGitHub,
  zlib,
}:

stdenv.mkDerivation rec {
  pname = "minimap2";
  version = "2.29";

  src = fetchFromGitHub {
    repo = "minimap2";
    owner = "lh3";
    rev = "v${version}";
    sha256 = "sha256-AIcxlEDHZOZgUOUZLRwmm5yuuzKHNz21rrSXAWGJEHk=";
  };

  buildInputs = [ zlib ];

  makeFlags = lib.optionals stdenv.hostPlatform.isAarch64 [
    "arm_neon=1"
    "aarch64=1"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp minimap2 $out/bin
    mkdir -p $out/share/man/man1
    cp minimap2.1 $out/share/man/man1
  '';

  meta = with lib; {
    description = "Versatile pairwise aligner for genomic and spliced nucleotide sequences";
    mainProgram = "minimap2";
    homepage = "https://lh3.github.io/minimap2";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [ maintainers.arcadio ];
  };
}
