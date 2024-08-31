# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.15
	anstyle@1.0.8
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	arbitrary@1.3.2
	arrayvec@0.7.6
	autocfg@1.3.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@2.6.0
	block-buffer@0.10.4
	bstr@1.10.0
	bumpalo@3.16.0
	byteorder@1.5.0
	cc@1.1.13
	cfg-if@1.0.0
	chrono@0.4.38
	chrono-tz@0.9.0
	chrono-tz-build@0.3.0
	clap@4.5.16
	clap_builder@4.5.15
	clap_lex@0.7.2
	colorchoice@1.0.2
	colored@2.1.0
	core-foundation-sys@0.8.7
	cpufeatures@0.2.13
	crossbeam-channel@0.5.13
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	dashmap@6.0.1
	derive_arbitrary@1.3.2
	deunicode@1.6.0
	digest@0.10.7
	either@1.13.0
	encoding_rs@0.8.34
	encoding_rs_io@0.1.7
	env_filter@0.1.2
	env_logger@0.11.5
	equivalent@1.0.1
	errno@0.3.9
	etcetera@0.8.0
	fastrand@2.1.0
	fnv@1.0.7
	form_urlencoded@1.2.1
	generic-array@0.14.7
	getrandom@0.2.15
	git2@0.19.0
	globset@0.4.14
	globwalk@0.9.1
	grep-matcher@0.1.7
	grep-searcher@0.1.13
	half@1.8.3
	hashbrown@0.14.5
	heck@0.5.0
	hex@0.4.3
	home@0.5.9
	humansize@2.1.3
	humantime@2.1.0
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	idna@0.5.0
	ignore@0.4.22
	indexmap@2.4.0
	is_terminal_polyfill@1.70.1
	itertools@0.11.0
	itoa@1.0.11
	jobserver@0.1.32
	js-sys@0.3.70
	json5@0.4.1
	lazy_static@1.5.0
	libc@0.2.156
	libgit2-sys@0.17.0+1.8.1
	libm@0.2.8
	libz-sys@1.1.19
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	memchr@2.7.4
	memmap2@0.9.4
	num-format@0.4.4
	num-traits@0.2.19
	once_cell@1.19.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	parse-zoneinfo@0.3.1
	percent-encoding@2.3.1
	pest@2.7.11
	pest_derive@2.7.11
	pest_generator@2.7.11
	pest_meta@2.7.11
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	pkg-config@0.3.30
	ppv-lite86@0.2.20
	proc-macro2@1.0.86
	proptest@1.5.0
	quick-error@1.2.3
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_xorshift@0.3.0
	rayon@1.10.0
	rayon-core@1.12.1
	redox_syscall@0.5.3
	regex@1.10.6
	regex-automata@0.4.7
	regex-syntax@0.8.4
	rustix@0.38.34
	rustversion@1.0.17
	rusty-fork@0.3.0
	ryu@1.0.18
	same-file@1.0.6
	scopeguard@1.2.0
	serde@1.0.208
	serde_cbor@0.11.2
	serde_derive@1.0.208
	serde_json@1.0.125
	serde_spanned@0.6.7
	serde_yaml@0.9.34+deprecated
	sha2@0.10.8
	shlex@1.3.0
	siphasher@0.3.11
	slug@0.1.6
	smallvec@1.13.2
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	syn@2.0.74
	table_formatter@0.6.1
	tempfile@3.12.0
	tera@1.20.0
	term_size@0.3.2
	terminal_size@0.3.0
	thiserror@1.0.63
	thiserror-impl@1.0.63
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.20
	typenum@1.17.0
	ucd-trie@0.1.6
	unarray@0.1.4
	unic-char-property@0.9.0
	unic-char-range@0.9.0
	unic-common@0.9.0
	unic-segment@0.9.0
	unic-ucd-segment@0.9.0
	unic-ucd-version@0.9.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unsafe-libyaml@0.2.11
	url@2.5.2
	utf8parse@0.2.2
	vcpkg@0.2.15
	version_check@0.9.5
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.93
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-shared@0.2.93
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.6.18
	zerocopy@0.7.35
	zerocopy-derive@0.7.35
"

inherit cargo

MY_PV="${PV/_alpha/-alpha.}"

DESCRIPTION="Count your code, quickly"
HOMEPAGE="https://github.com/XAMPPRocky/tokei"
SRC_URI="
	https://github.com/XAMPPRocky/tokei/archive/v${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD BSD-2 CC0-1.0 MIT ZLIB || ( Apache-2.0 Boost-1.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		virtual/pkgconfig
		>=dev-libs/libgit2-1.1.0
	)
"

QA_FLAGS_IGNORED="usr/bin/tokei"

src_configure() {
	cargo_src_configure --features all
}

src_install() {
	cargo_src_install
	dodoc CHANGELOG.md README.md tokei.example.toml
}
