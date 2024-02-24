# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# AG_PV="${PV}"
AG_PV="0.25.0"

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.9
	aho-corasick@1.1.2
	allocator-api2@0.2.16
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.12
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anyhow@1.0.80
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.7
	bincode@1.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.4.2
	bugreport@0.5.0
	bumpalo@3.15.1
	bwrap@1.3.0
	bytesize@1.3.0
	cassowary@0.3.0
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.34
	clap@4.5.1
	clap_builder@4.5.1
	clap_lex@0.7.0
	colorchoice@1.0.0
	core-foundation-sys@0.8.6
	crc32fast@1.4.0
	crossbeam-channel@0.5.11
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	dashmap@5.5.3
	deranged@0.3.11
	diff@0.1.13
	dirs@5.0.1
	dirs-sys@0.4.1
	easy-cast@0.5.2
	either@1.10.0
	env_filter@0.1.0
	env_logger@0.11.2
	equivalent@1.0.1
	errno@0.3.8
	fancy-regex@0.11.0
	fastrand@2.0.1
	filetime@0.2.23
	filetreelist@0.5.1
	flate2@1.0.28
	fnv@1.0.7
	form_urlencoded@1.2.1
	fsevent-sys@4.1.0
	futures@0.3.30
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	fuzzy-matcher@0.3.7
	getrandom@0.2.12
	gh-emoji@1.0.8
	gimli@0.28.1
	git-version@0.3.9
	git-version-macro@0.3.9
	git2@0.18.2
	git2-hooks@0.3.1
	git2-testing@0.1.0
	hashbrown@0.14.3
	heck@0.4.1
	home@0.5.9
	humantime@2.1.0
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	idna@0.5.0
	indexmap@2.2.3
	indoc@2.0.4
	inotify@0.9.6
	inotify-sys@0.1.5
	invalidstring@0.1.3
	itertools@0.11.0
	itertools@0.12.1
	itoa@1.0.10
	jobserver@0.1.28
	js-sys@0.3.68
	kqueue@1.0.8
	kqueue-sys@1.0.4
	lazy_static@1.4.0
	libc@0.2.153
	libgit2-sys@0.16.2+1.7.2
	libredox@0.0.1
	libssh2-sys@0.3.0
	libz-sys@1.1.15
	linux-raw-sys@0.4.13
	lock_api@0.4.11
	log@0.4.20
	lru@0.12.2
	memchr@2.7.1
	miniz_oxide@0.7.2
	mio@0.8.10
	notify@6.1.1
	notify-debouncer-mini@0.4.1
	num-conv@0.1.0
	num-traits@0.2.18
	object@0.32.2
	once_cell@1.19.0
	onig@6.4.0
	onig_sys@69.8.1
	openssl-probe@0.1.5
	openssl-src@300.2.3+3.2.1
	openssl-sys@0.9.101
	option-ext@0.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	paste@1.0.14
	percent-encoding@2.3.1
	phf@0.11.2
	phf_shared@0.11.2
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.30
	powerfmt@0.2.0
	pretty_assertions@1.4.0
	proc-macro2@1.0.78
	quote@1.0.35
	ratatui@0.24.0
	rayon@1.8.1
	rayon-core@1.12.1
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex@1.10.3
	regex-automata@0.4.5
	regex-syntax@0.8.2
	ron@0.8.1
	rustc-demangle@0.1.23
	rustix@0.38.31
	rustversion@1.0.14
	ryu@1.0.16
	same-file@1.0.6
	scopeguard@1.2.0
	scopetime@0.1.2
	serde@1.0.197
	serde_derive@1.0.197
	serde_json@1.0.113
	serial_test@3.0.0
	serial_test_derive@3.0.0
	shell-escape@0.1.5
	shellexpand@3.1.0
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	simplelog@0.12.1
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.1
	strsim@0.11.0
	struct-patch@0.4.1
	struct-patch-derive@0.4.1
	strum@0.25.0
	strum_macros@0.25.3
	syn@2.0.49
	syntect@5.2.0
	sys-info@0.9.1
	tempfile@3.10.0
	thiserror@1.0.57
	thiserror-impl@1.0.57
	thread_local@1.1.7
	time@0.3.34
	time-core@0.1.2
	time-macros@0.2.17
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tui-textarea@0.4.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	unicode-segmentation@1.11.0
	unicode-truncate@0.2.0
	unicode-width@0.1.11
	url@2.5.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.91
	wasm-bindgen-backend@0.2.91
	wasm-bindgen-macro@0.2.91
	wasm-bindgen-macro-support@0.2.91
	wasm-bindgen-shared@0.2.91
	which@6.0.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	yansi@0.5.1
	zerocopy@0.7.32
	zerocopy-derive@0.7.32
	asyncgit@${AG_PV}
	${PN}@${PV}
"

inherit cargo

DESCRIPTION="Blazing fast terminal-ui for git"
HOMEPAGE="
	https://crates.io/crates/gitui
	https://github.com/extrawurst/gitui
"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD CDDL ISC MIT Unicode-DFS-2016
	|| ( Artistic-2 CC0-1.0 )
"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="ghemoji trace-libgit"

RDEPEND="
	>=dev-libs/libgit2-1.2.0:=
	trace-libgit? ( dev-libs/libgit2[trace(+)] )

	dev-libs/openssl
"
DEPEND="${RDEPEND}"

RESTRICT="mirror"

src_configure() {
	local myfeatures=(
		$(usev ghemoji)
		$(usev trace-libgit)
		regex-fancy
	)

	cargo_src_configure --no-default-features
}

src_install() {
	local DOCS=({README,KEY_CONFIG,THEMES}.md)

	cargo_src_install

	insinto "/usr/share/${P}/examples"
	doins vim_style_key_config.ron

	einstalldocs
}

pkg_postinst() {
	einfo "Example of vim keybindings config stored in '/usr/share/${P}/examples'"
	einfo 'to use it put example config in `$XDG_CONFIG_HOME/gitui/key_bindings.ron`'
}
