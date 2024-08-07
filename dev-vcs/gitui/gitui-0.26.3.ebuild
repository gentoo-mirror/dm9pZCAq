# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

AG_PV="${PV}"

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aead@0.5.2
	aes@0.8.4
	aes-gcm@0.10.3
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.14
	anstyle@1.0.7
	anstyle-parse@0.2.4
	anstyle-query@1.0.3
	anstyle-wincon@3.0.3
	anyhow@1.0.86
	autocfg@1.3.0
	backtrace@0.3.71
	base16ct@0.2.0
	base64@0.21.7
	base64ct@1.6.0
	bcrypt-pbkdf@0.10.0
	bincode@1.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.5.0
	block-buffer@0.10.4
	block-padding@0.3.3
	blowfish@0.9.1
	bugreport@0.5.0
	bumpalo@3.16.0
	bwrap@1.3.0
	byteorder@1.5.0
	bytesize@1.3.0
	cassowary@0.3.0
	castaway@0.2.2
	cbc@0.1.2
	cc@1.0.98
	cfg-if@1.0.0
	chacha20@0.9.1
	chrono@0.4.38
	cipher@0.4.4
	clap@4.5.4
	clap_builder@4.5.2
	clap_lex@0.7.0
	colorchoice@1.0.1
	compact_str@0.7.1
	const-oid@0.9.6
	core-foundation-sys@0.8.6
	cpufeatures@0.2.12
	crc32fast@1.4.2
	crossbeam-channel@0.5.13
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	crypto-bigint@0.5.5
	crypto-common@0.1.6
	ctr@0.9.2
	curve25519-dalek@4.1.2
	curve25519-dalek-derive@0.1.1
	der@0.7.9
	deranged@0.3.11
	diff@0.1.13
	digest@0.10.7
	dirs@5.0.1
	dirs-sys@0.4.1
	easy-cast@0.5.2
	ecdsa@0.16.9
	ed25519@2.2.3
	ed25519-dalek@2.1.1
	either@1.12.0
	elliptic-curve@0.13.8
	env_filter@0.1.0
	env_logger@0.11.3
	equivalent@1.0.1
	errno@0.3.9
	fancy-regex@0.11.0
	fastrand@2.1.0
	ff@0.13.0
	fiat-crypto@0.2.9
	filetime@0.2.23
	filetreelist@0.5.1
	flate2@1.0.30
	fnv@1.0.7
	form_urlencoded@1.2.1
	fsevent-sys@4.1.0
	fuzzy-matcher@0.3.7
	generic-array@0.14.7
	getrandom@0.2.15
	gh-emoji@1.0.8
	ghash@0.5.1
	gimli@0.28.1
	git-version@0.3.9
	git-version-macro@0.3.9
	git2@0.18.3
	git2-hooks@0.3.1
	group@0.13.0
	hashbrown@0.14.5
	heck@0.4.1
	hmac@0.12.1
	home@0.5.9
	humantime@2.1.0
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	idna@0.5.0
	indexmap@2.2.6
	inotify@0.9.6
	inotify-sys@0.1.5
	inout@0.1.3
	is_terminal_polyfill@1.70.0
	itertools@0.12.1
	itoa@1.0.11
	jobserver@0.1.31
	js-sys@0.3.69
	kqueue@1.0.8
	kqueue-sys@1.0.4
	lazy_static@1.4.0
	libc@0.2.155
	libgit2-sys@0.16.2+1.7.2
	libm@0.2.8
	libredox@0.1.3
	libssh2-sys@0.3.0
	libz-sys@1.1.16
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.21
	lru@0.12.3
	memchr@2.7.2
	miniz_oxide@0.7.3
	mio@0.8.11
	notify@6.1.1
	notify-debouncer-mini@0.4.1
	num-bigint-dig@0.8.4
	num-conv@0.1.0
	num-integer@0.1.46
	num-iter@0.1.45
	num-traits@0.2.19
	object@0.32.2
	once_cell@1.19.0
	onig@6.4.0
	onig_sys@69.8.1
	opaque-debug@0.3.1
	openssl-probe@0.1.5
	openssl-src@300.2.3+3.2.1
	openssl-sys@0.9.102
	option-ext@0.2.0
	p256@0.13.2
	p384@0.13.0
	p521@0.13.3
	parking_lot@0.12.2
	parking_lot_core@0.9.9
	paste@1.0.15
	pbkdf2@0.12.2
	pem-rfc7468@0.7.0
	percent-encoding@2.3.1
	phf@0.11.2
	phf_shared@0.11.2
	pkcs1@0.7.5
	pkcs8@0.10.2
	pkg-config@0.3.30
	platforms@3.4.0
	poly1305@0.8.0
	polyval@0.6.2
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	pretty_assertions@1.4.0
	primeorder@0.13.6
	proc-macro2@1.0.83
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	ratatui@0.26.3
	rayon@1.10.0
	rayon-core@1.12.1
	redox_syscall@0.4.1
	redox_users@0.4.5
	regex@1.10.4
	regex-automata@0.4.6
	regex-syntax@0.8.3
	rfc6979@0.4.0
	ron@0.8.1
	rsa@0.9.6
	rustc-demangle@0.1.24
	rustc_version@0.4.0
	rustix@0.38.34
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	scopeguard@1.2.0
	scopetime@0.1.2
	sec1@0.7.3
	semver@1.0.23
	serde@1.0.202
	serde_derive@1.0.202
	serde_json@1.0.117
	sha2@0.10.8
	shell-escape@0.1.5
	shellexpand@3.1.0
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.2
	signature@2.2.0
	simplelog@0.12.2
	siphasher@0.3.11
	smallvec@1.13.2
	spin@0.5.2
	spki@0.7.3
	ssh-cipher@0.2.0
	ssh-encoding@0.2.0
	ssh-key@0.6.6
	stability@0.2.0
	static_assertions@1.1.0
	strsim@0.11.1
	struct-patch@0.4.1
	struct-patch-derive@0.4.1
	strum@0.26.2
	strum_macros@0.26.2
	subtle@2.5.0
	syn@2.0.65
	syntect@5.2.0
	sys-info@0.9.1
	tempfile@3.10.1
	thiserror@1.0.61
	thiserror-impl@1.0.61
	thread_local@1.1.8
	time@0.3.36
	time-core@0.1.2
	time-macros@0.2.18
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tui-textarea@0.4.0
	two-face@0.4.0
	typenum@1.17.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unicode-segmentation@1.11.0
	unicode-truncate@1.0.0
	unicode-width@0.1.12
	universal-hash@0.5.1
	url@2.5.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	which@6.0.1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winsafe@0.0.19
	yansi@0.5.1
	zerocopy@0.7.34
	zerocopy-derive@0.7.34
	zeroize@1.7.0
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
	Apache-2.0 BSD-2 BSD CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016
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
