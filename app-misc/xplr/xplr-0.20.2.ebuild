# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( luajit )

CRATES="
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	anes-0.1.6
	ansi-to-tui-2.0.0
	anyhow-1.0.68
	assert_cmd-2.0.8
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bstr-0.2.17
	bstr-1.1.0
	bumpalo-3.11.1
	cassowary-0.3.0
	cast-0.3.0
	cc-1.0.78
	cfg-if-1.0.0
	chrono-0.4.23
	ciborium-0.2.0
	ciborium-io-0.2.0
	ciborium-ll-0.2.0
	clap-3.2.23
	clap_lex-0.2.4
	codespan-reporting-0.11.1
	core-foundation-sys-0.8.3
	criterion-0.4.0
	criterion-plot-0.5.0
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.13
	crossbeam-utils-0.8.14
	crossterm-0.25.0
	crossterm_winapi-0.9.0
	cxx-1.0.86
	cxx-build-1.0.86
	cxxbridge-flags-1.0.86
	cxxbridge-macro-1.0.86
	difflib-0.4.0
	dirs-4.0.0
	dirs-sys-0.3.7
	doc-comment-0.3.3
	either-1.8.0
	erased-serde-0.3.24
	fuzzy-matcher-0.3.7
	gethostname-0.4.1
	getrandom-0.2.8
	half-1.8.2
	hashbrown-0.12.3
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	humansize-2.1.3
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	indexmap-1.9.2
	itertools-0.10.5
	itoa-1.0.5
	js-sys-0.3.60
	lazy_static-1.4.0
	libc-0.2.139
	libm-0.2.6
	link-cplusplus-1.0.8
	lock_api-0.4.9
	log-0.4.17
	lua-src-544.0.1
	luajit-src-210.4.5+resty2cf5186
	memchr-2.5.0
	memoffset-0.7.1
	mime-0.3.16
	mime_guess-2.0.4
	minimal-lexical-0.2.1
	mio-0.8.5
	mlua-0.8.7
	natord-1.0.9
	nom-7.1.2
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.15.0
	once_cell-1.17.0
	oorandom-11.1.3
	os_str_bytes-6.4.1
	parking_lot-0.12.1
	parking_lot_core-0.9.6
	path-absolutize-3.0.14
	path-dedot-3.0.18
	pkg-config-0.3.26
	plotters-0.3.4
	plotters-backend-0.3.4
	plotters-svg-0.3.3
	predicates-2.1.5
	predicates-core-1.0.5
	predicates-tree-1.0.7
	proc-macro2-1.0.49
	quote-1.0.23
	rayon-1.6.1
	rayon-core-1.10.1
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.7.1
	regex-automata-0.1.10
	regex-syntax-0.6.28
	rustc-hash-1.1.0
	ryu-1.0.12
	same-file-1.0.6
	scopeguard-1.1.0
	scratch-1.0.3
	serde-1.0.152
	serde_derive-1.0.152
	serde_json-1.0.91
	serde_yaml-0.9.16
	signal-hook-0.3.14
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.0
	smallvec-1.10.0
	syn-1.0.107
	termcolor-1.1.3
	termtree-0.4.0
	textwrap-0.16.0
	thiserror-1.0.38
	thiserror-impl-1.0.38
	thread_local-1.1.4
	time-0.1.45
	tinytemplate-1.2.1
	tui-0.19.0
	tui-input-0.6.1
	unicase-2.6.0
	unicode-ident-1.0.6
	unicode-segmentation-1.10.0
	unicode-width-0.1.10
	unsafe-libyaml-0.2.5
	version_check-0.9.4
	wait-timeout-0.2.0
	walkdir-2.3.2
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	web-sys-0.3.60
	which-4.3.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.43.0
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.42.1
	${P}
"

inherit cargo desktop lua-single

DESCRIPTION="A hackable, minimal, fast TUI file explorer"
HOMEPAGE="
	https://crates.io/crates/xplr
	https://github.com/sayanarijit/xplr
"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

REQUIRED_USE="${LUA_REQUIRED_USE}"
RDEPEND="${LUA_DEPS}"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i Cargo.toml -e 's/"vendored"\s*,//' || die
	# for dynamic linking with lua

	default
}

src_install() {
	local DOCS=( docs/* )

	dobin "target/release/${PN}"

	einstalldocs
}
