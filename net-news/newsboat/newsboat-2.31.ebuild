# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
# private crates:
#	libnewsboat
#	libnewsboat-ffi
#	regex-rs
#	strprintf
CRATES="
	addr2line-0.19.0
	adler-1.0.2
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	autocfg-1.1.0
	backtrace-0.3.67
	bit-set-0.5.3
	bit-vec-0.6.3
	bitflags-1.3.2
	bitflags-2.0.2
	block-0.1.6
	bumpalo-3.11.1
	byteorder-1.4.3
	cc-1.0.78
	cfg-if-1.0.0
	chrono-0.4.24
	codespan-reporting-0.11.1
	core-foundation-sys-0.8.3
	curl-sys-0.4.61+curl-8.0.1
	cxx-1.0.93
	cxx-build-1.0.93
	cxxbridge-flags-1.0.93
	cxxbridge-macro-1.0.93
	dirs-4.0.0
	dirs-sys-0.3.7
	errno-0.2.8
	errno-dragonfly-0.1.2
	fastrand-1.9.0
	fnv-1.0.7
	form_urlencoded-1.1.0
	getrandom-0.2.8
	gettext-rs-0.7.0
	gettext-sys-0.21.3
	gimli-0.27.0
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	idna-0.3.0
	instant-0.1.12
	io-lifetimes-1.0.5
	js-sys-0.3.60
	lazy_static-1.4.0
	lexopt-0.3.0
	libc-0.2.140
	libz-sys-1.1.8
	link-cplusplus-1.0.8
	linux-raw-sys-0.1.4
	locale_config-0.3.0
	log-0.4.17
	malloc_buf-0.0.6
	md5-0.7.0
	memchr-2.5.0
	minimal-lexical-0.2.1
	miniz_oxide-0.6.2
	natord-1.0.9
	nom-7.1.3
	num-integer-0.1.45
	num-traits-0.2.15
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	object-0.30.0
	once_cell-1.17.1
	percent-encoding-2.2.0
	pkg-config-0.3.26
	ppv-lite86-0.2.17
	proc-macro2-1.0.52
	proptest-1.0.0
	quick-error-1.2.3
	quick-error-2.0.1
	quote-1.0.26
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	rand_xorshift-0.3.0
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.7.0
	regex-syntax-0.6.28
	rustc-demangle-0.1.21
	rustix-0.36.8
	rusty-fork-0.3.0
	scratch-1.0.3
	section_testing-0.0.5
	syn-1.0.107
	syn-2.0.2
	temp-dir-0.1.11
	tempfile-3.4.0
	termcolor-1.1.3
	thiserror-1.0.38
	thiserror-impl-1.0.38
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	unicode-bidi-0.3.8
	unicode-ident-1.0.6
	unicode-normalization-0.1.22
	unicode-width-0.1.10
	url-2.3.1
	vcpkg-0.2.15
	wait-timeout-0.2.0
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.42.0
	windows-sys-0.45.0
	windows-targets-0.42.1
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.42.1
	xdg-2.4.1
"

inherit toolchain-funcs cargo

DESCRIPTION="An RSS/Atom feed reader for text terminals"
HOMEPAGE="https://newsboat.org/ https://github.com/newsboat/newsboat"
SRC_URI="
	https://newsboat.org/releases/${PV}/${P}.tar.xz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="Apache-2.0 BSD-2 Boost-1.0 CC0-1.0 ISC MIT Unlicense"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc64 x86"
IUSE="doc"

RDEPEND="
	>=dev-db/sqlite-3.5:3
	>=dev-libs/stfl-0.21
	>=net-misc/curl-7.21.6
	>=dev-libs/json-c-0.11:=
	dev-libs/libxml2
	sys-libs/ncurses:0=
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	sys-libs/zlib
	doc? ( dev-ruby/asciidoctor )
	<dev-libs/openssl-1.1.2:0=
"

src_configure() {
	sed -i Makefile \
		-e '/^WARNFLAGS\s*=/s/-Werror//' \
		-e '/^BARE_CXXFLAGS\s*=/s/-[Og][^ ]\+//g'

	use doc || {
		sed -i Makefile \
			-e '/^all:/s/doc//' \
			-e '/^install:/s/install-docs//'
	}

	./config.sh || die
}

src_compile() {
	export CARGO_HOME="${ECARGO_HOME}"
	emake prefix=/usr CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)"
}

src_test() {
	# tests require UTF-8 locale
	emake CXX="$(tc-getCXX)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" test
	# Tests fail if in ${S} rather than in ${S}/test
	cd "${S}/test" || die
	./test || die
}

src_install() {
	emake DESTDIR="${ED}" prefix=/usr docdir="/usr/share/doc/${PF}" install
	einstalldocs
}
