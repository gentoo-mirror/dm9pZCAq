# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( luajit )

CRATES="
	aho-corasick-0.7.18
	ansi-to-tui-forked-0.5.2-fix.offset
	anyhow-1.0.57
	assert_cmd-2.0.4
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bstr-0.2.17
	bumpalo-3.10.0
	cassowary-0.3.0
	cast-0.2.7
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.34.0
	criterion-0.3.5
	criterion-plot-0.4.4
	crossbeam-channel-0.5.4
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.8
	crossbeam-utils-0.8.8
	crossterm-0.23.2
	crossterm_winapi-0.9.0
	csv-1.1.6
	csv-core-0.1.10
	difflib-0.4.0
	dirs-4.0.0
	dirs-sys-0.3.7
	doc-comment-0.3.3
	either-1.6.1
	erased-serde-0.3.20
	gethostname-0.2.3
	getrandom-0.2.6
	half-1.8.2
	hashbrown-0.11.2
	hermit-abi-0.1.19
	humansize-1.1.1
	indexmap-1.8.2
	itertools-0.10.3
	itoa-0.4.8
	itoa-1.0.2
	js-sys-0.3.57
	lazy_static-1.4.0
	libc-0.2.126
	linked-hash-map-0.5.4
	lock_api-0.4.7
	log-0.4.17
	lua-src-544.0.1
	luajit-src-210.4.0+resty124ff8d
	memchr-2.5.0
	memoffset-0.6.5
	mime-0.3.16
	mime_guess-2.0.4
	mio-0.8.3
	mlua-0.7.4
	natord-1.0.9
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.13.1
	once_cell-1.12.0
	oorandom-11.1.3
	parking_lot-0.12.1
	parking_lot_core-0.9.3
	pkg-config-0.3.25
	plotters-0.3.1
	plotters-backend-0.3.2
	plotters-svg-0.3.1
	predicates-2.1.1
	predicates-core-1.0.3
	predicates-tree-1.0.5
	proc-macro2-1.0.39
	quote-1.0.18
	rayon-1.5.3
	rayon-core-1.9.3
	redox_syscall-0.2.13
	redox_users-0.4.3
	regex-1.5.6
	regex-automata-0.1.10
	regex-syntax-0.6.26
	rustc-hash-1.1.0
	rustc_version-0.4.0
	ryu-1.0.10
	same-file-1.0.6
	scopeguard-1.1.0
	semver-1.0.9
	serde-1.0.137
	serde_cbor-0.11.2
	serde_derive-1.0.137
	serde_json-1.0.81
	serde_yaml-0.8.24
	signal-hook-0.3.14
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.0
	smallvec-1.8.0
	syn-1.0.96
	termtree-0.2.4
	textwrap-0.11.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	time-0.1.44
	tinytemplate-1.2.1
	tui-0.18.0
	tui-input-0.4.2
	unicase-2.6.0
	unicode-ident-1.0.0
	unicode-segmentation-1.9.0
	unicode-width-0.1.9
	version_check-0.9.4
	wait-timeout-0.2.0
	walkdir-2.3.2
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.80
	wasm-bindgen-backend-0.2.80
	wasm-bindgen-macro-0.2.80
	wasm-bindgen-macro-support-0.2.80
	wasm-bindgen-shared-0.2.80
	web-sys-0.3.57
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.36.1
	yaml-rust-0.4.5
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
