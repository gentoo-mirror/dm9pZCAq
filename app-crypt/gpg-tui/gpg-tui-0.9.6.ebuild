# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	android_system_properties@0.1.5
	anstream@0.3.2
	anstyle@1.0.0
	anstyle-parse@0.2.0
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	anyhow@1.0.71
	autocfg@1.1.0
	bitflags@1.3.2
	block@0.1.6
	block-buffer@0.10.4
	build-rs@0.1.2
	bumpalo@3.13.0
	bytemuck@1.13.1
	byteorder@1.4.3
	cassowary@0.3.0
	cc@1.0.79
	cfg-expr@0.15.1
	cfg-if@1.0.0
	chrono@0.4.24
	clap@4.3.0
	clap_builder@4.3.0
	clap_complete@4.3.0
	clap_derive@4.3.0
	clap_lex@0.5.0
	clipboard-win@3.1.1
	color_quant@1.1.0
	colorchoice@1.0.0
	colorsys@0.6.7
	conv@0.3.3
	copypasta@0.8.2
	copypasta-ext@0.4.4
	core-foundation-sys@0.8.4
	cpufeatures@0.2.7
	crossterm@0.26.1
	crossterm_winapi@0.9.0
	crypto-common@0.1.6
	cstr-argument@0.1.2
	ctor@0.1.26
	custom_derive@0.1.7
	diff@0.1.13
	digest@0.10.7
	dirs@5.0.1
	dirs-next@2.0.0
	dirs-sys@0.4.1
	dirs-sys-next@0.1.2
	dlib@0.5.0
	downcast-rs@1.2.0
	either@1.8.1
	errno@0.3.1
	errno-dragonfly@0.1.2
	generic-array@0.14.7
	gethostname@0.2.3
	getrandom@0.2.9
	gpg-error@0.6.0
	gpgme@0.11.0
	gpgme-sys@0.11.0
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.3.1
	hex-literal@0.4.1
	iana-time-zone@0.1.56
	iana-time-zone-haiku@0.1.2
	image@0.24.6
	indexmap@1.9.3
	io-lifetimes@1.0.11
	is-terminal@0.4.7
	itoa@1.0.6
	jpeg-decoder@0.3.0
	js-sys@0.3.63
	lazy-bytes-cast@5.0.1
	lazy_static@1.4.0
	libc@0.2.144
	libgpg-error-sys@0.6.0
	libloading@0.7.4
	linux-raw-sys@0.3.8
	lock_api@0.4.9
	log@0.4.17
	malloc_buf@0.0.6
	memchr@2.5.0
	memmap2@0.5.10
	memoffset@0.6.5
	memoffset@0.7.1
	minimal-lexical@0.2.1
	mio@0.8.6
	nix@0.24.3
	nom@7.1.3
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.15
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	once_cell@1.17.1
	option-ext@0.2.0
	output_vt100@0.1.3
	parking_lot@0.12.1
	parking_lot_core@0.9.7
	pkg-config@0.3.27
	pretty_assertions@1.3.0
	proc-macro2@1.0.58
	quote@1.0.27
	ratatui@0.20.1
	redox_syscall@0.2.16
	redox_users@0.4.3
	rust-embed@6.6.1
	rust-embed-impl@6.5.0
	rust-embed-utils@7.5.0
	rustix@0.37.19
	ryu@1.0.13
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.1.0
	serde@1.0.163
	serde_derive@1.0.163
	serde_json@1.0.96
	serde_spanned@0.6.2
	sha2@0.10.6
	shellexpand@3.1.0
	signal-hook@0.3.15
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	smallvec@1.10.0
	smithay-client-toolkit@0.16.0
	smithay-clipboard@0.6.6
	static_assertions@1.1.0
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.16
	system-deps@6.1.0
	target-lexicon@0.12.7
	terminal_size@0.2.6
	thiserror@1.0.40
	thiserror-impl@1.0.40
	time@0.1.45
	tinytemplate@1.2.1
	toml@0.7.4
	toml_datetime@0.6.2
	toml_edit@0.19.10
	typenum@1.16.0
	unicode-ident@1.0.9
	unicode-segmentation@1.10.1
	unicode-width@0.1.10
	utf8parse@0.2.1
	version-compare@0.1.1
	version_check@0.9.4
	walkdir@2.3.3
	wasi@0.10.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.86
	wasm-bindgen-backend@0.2.86
	wasm-bindgen-macro@0.2.86
	wasm-bindgen-macro-support@0.2.86
	wasm-bindgen-shared@0.2.86
	wayland-client@0.29.5
	wayland-commons@0.29.5
	wayland-cursor@0.29.5
	wayland-protocols@0.29.5
	wayland-scanner@0.29.5
	wayland-sys@0.29.5
	which@4.4.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.48.0
	windows-sys@0.45.0
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
	winnow@0.4.6
	winreg@0.10.1
	x11-clipboard@0.7.1
	x11rb@0.10.1
	x11rb-protocol@0.10.0
	xcursor@0.3.4
	xml-rs@0.8.13
	yansi@0.5.1
	${PN}@${PV}
"

inherit bash-completion-r1 cargo

DESCRIPTION="Terminal User Interface for GnuPG"
HOMEPAGE="
	https://crates.io/crates/gpg-tui
	https://github.com/orhun/gpg-tui
"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/orhun/${PN}/raw/v${PV}/man/${PN}.1 -> ${P}.man.1
	https://github.com/orhun/${PN}/raw/v${PV}/man/${PN}.toml.5
		-> ${P}.toml.man.5
"

LICENSE="Apache-2.0 BSD Boost-1.0 ISC LGPL-2.1 MIT Unlicense"
SLOT="0"
KEYWORDS="amd64 ~x86"
RESTRICT="mirror"

DEPEND="
	app-crypt/gpgme
	dev-libs/libgpg-error
	x11-libs/libxcb
"
RDEPEND="${DEPEND}"
BDEPEND="x11-libs/libxkbcommon"

src_unpack() {
	cargo_src_unpack

	local man="${T}/man"
	mkdir -- "${man}" || die
	cp -v -- "${DISTDIR}/${P}.man.1" "${man}/${PN}.1" || die
	cp -v -- "${DISTDIR}/${P}.toml.man.5" "${man}/${PN}.toml.5" || die
}

src_compile() {
	local completions="${S}/completions"

	cargo_src_compile

	ebegin "generating completions"

	mkdir -p -- "${completions}" || die
	OUT_DIR="${completions}" "./target/release/${PN}-completions"

	eend "${?}" 'failed to generate completions' || die "${_}"
}

src_install() {
	dobin "target/release/${PN}"

	doman "${T}/man"/*

	# bash-completion
	newbashcomp "completions/${PN}.bash" "${PN}"

	# zsh-completion
	insinto /usr/share/zsh/site-functions
	doins "completions/_${PN}"

	# fish-completion
	insinto /usr/share/fish/vendor_completions.d
	doins "completions/${PN}.fish"
}
