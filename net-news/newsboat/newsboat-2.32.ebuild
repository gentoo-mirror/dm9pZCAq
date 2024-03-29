# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
# private crates:
#	libnewsboat
#	libnewsboat-ffi
#	regex-rs
#	strprintf
CRATES="
	addr2line@0.19.0
	adler@1.0.2
	aho-corasick@0.7.20
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	autocfg@1.1.0
	backtrace@0.3.67
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.3.2
	block@0.1.6
	bumpalo@3.12.0
	byteorder@1.4.3
	cc@1.0.79
	cfg-if@1.0.0
	chrono@0.4.26
	codespan-reporting@0.11.1
	core-foundation-sys@0.8.3
	curl-sys@0.4.63+curl-8.1.2
	cxx@1.0.97
	cxx-build@1.0.97
	cxxbridge-flags@1.0.97
	cxxbridge-macro@1.0.97
	errno@0.3.1
	errno-dragonfly@0.1.2
	fastrand@1.9.0
	fnv@1.0.7
	form_urlencoded@1.2.0
	getrandom@0.2.8
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gimli@0.27.2
	hermit-abi@0.3.1
	home@0.5.5
	iana-time-zone@0.1.54
	iana-time-zone-haiku@0.1.1
	idna@0.4.0
	instant@0.1.12
	io-lifetimes@1.0.11
	js-sys@0.3.61
	lazy_static@1.4.0
	lexopt@0.3.0
	libc@0.2.146
	libm@0.2.6
	libz-sys@1.1.8
	link-cplusplus@1.0.8
	linux-raw-sys@0.3.8
	locale_config@0.3.0
	log@0.4.17
	malloc_buf@0.0.6
	md5@0.7.0
	memchr@2.5.0
	minimal-lexical@0.2.1
	miniz_oxide@0.6.2
	natord@1.0.9
	nom@7.1.3
	num-traits@0.2.15
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	object@0.30.3
	once_cell@1.18.0
	percent-encoding@2.3.0
	pkg-config@0.3.26
	ppv-lite86@0.2.17
	proc-macro2@1.0.59
	proptest@1.1.0
	quick-error@1.2.3
	quick-error@2.0.1
	quote@1.0.26
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_xorshift@0.3.0
	redox_syscall@0.3.5
	regex@1.7.3
	regex-syntax@0.6.29
	rustc-demangle@0.1.22
	rustix@0.37.19
	rusty-fork@0.3.0
	scratch@1.0.5
	section_testing@0.0.5
	syn@1.0.109
	syn@2.0.12
	temp-dir@0.1.11
	tempfile@3.6.0
	termcolor@1.2.0
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	unarray@0.1.4
	unicode-bidi@0.3.13
	unicode-ident@1.0.8
	unicode-normalization@0.1.22
	unicode-width@0.1.10
	url@2.4.0
	vcpkg@0.2.15
	wait-timeout@0.2.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.84
	wasm-bindgen-backend@0.2.84
	wasm-bindgen-macro@0.2.84
	wasm-bindgen-macro-support@0.2.84
	wasm-bindgen-shared@0.2.84
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.46.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.0
	xdg@2.5.0
"

inherit flag-o-matic toolchain-funcs cargo

DESCRIPTION="An RSS/Atom feed reader for text terminals"
HOMEPAGE="https://newsboat.org/ https://github.com/newsboat/newsboat"
SRC_URI="
	https://newsboat.org/releases/${PV}/${P}.tar.xz
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 BSD MIT Unlicense ZLIB"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc64 x86"
IUSE="doc"

RDEPEND="
	>=dev-db/sqlite-3.5:3
	>=dev-libs/json-c-0.11:=
	>=dev-libs/stfl-0.21
	>=net-misc/curl-7.21.6
	dev-libs/libxml2
	dev-libs/openssl:=
	sys-libs/ncurses:=[unicode(+)]
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"
BDEPEND="
	app-alternatives/awk
	doc? ( >=dev-ruby/asciidoctor-1.5.3 )
	virtual/pkgconfig
	>=virtual/rust-1.62.0
"

src_prepare() {
	default
	sed -i Makefile \
		-e '/^WARNFLAGS\s*=/s/-Werror//' \
		-e '/^BARE_CXXFLAGS\s*=/s/-[Og][^ ]\+//g'

	use doc || {
		sed -i Makefile \
			-e '/^all:/s/doc//' \
			-e '/^install:/s/install-docs//'
	}
}

src_configure() {
	filter-lto  # bug #877657
	./config.sh || die
}

src_compile() {
	export CARGO_HOME="${ECARGO_HOME}"
	emake prefix=/usr CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)"
}

src_test() {
	emake CC="${tc-getCC}" CXX="$(tc-getCXX)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" check || die
}

src_install() {
	emake DESTDIR="${ED}" prefix=/usr docdir="/usr/share/doc/${PF}" install
	einstalldocs
}
