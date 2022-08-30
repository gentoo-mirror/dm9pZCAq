# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	android_system_properties-0.1.4
	ansi_term-0.12.1
	anyhow-1.0.62
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	block-0.1.6
	block-buffer-0.9.0
	bumpalo-3.11.0
	bytemuck-1.12.1
	byteorder-1.4.3
	cassowary-0.3.0
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.4.22
	clap-3.2.17
	clap_complete-3.2.4
	clap_derive-3.2.17
	clap_lex-0.2.4
	clipboard-win-3.1.1
	color_quant-1.1.0
	colorsys-0.6.6
	conv-0.3.3
	copypasta-0.8.1
	copypasta-ext-0.3.9
	core-foundation-sys-0.8.3
	cpufeatures-0.2.2
	crossterm-0.25.0
	crossterm_winapi-0.9.0
	cstr-argument-0.1.2
	ctor-0.1.23
	custom_derive-0.1.7
	diff-0.1.13
	digest-0.9.0
	dirs-4.0.0
	dirs-next-2.0.0
	dirs-sys-0.3.7
	dirs-sys-next-0.1.2
	dlib-0.5.0
	downcast-rs-1.2.0
	either-1.8.0
	generic-array-0.14.6
	getrandom-0.2.7
	gpg-error-0.5.2
	gpgme-0.10.0
	gpgme-sys-0.10.0
	hashbrown-0.12.3
	heck-0.4.0
	hermit-abi-0.1.19
	hex-literal-0.3.4
	iana-time-zone-0.1.45
	image-0.24.3
	indexmap-1.9.1
	itoa-1.0.3
	jpeg-decoder-0.2.6
	js-sys-0.3.59
	lazy-bytes-cast-5.0.1
	lazy_static-1.4.0
	libc-0.2.132
	libgpg-error-sys-0.5.2
	libloading-0.7.3
	lock_api-0.4.7
	log-0.4.17
	malloc_buf-0.0.6
	memchr-2.5.0
	memmap2-0.5.7
	memoffset-0.6.5
	minimal-lexical-0.2.1
	mio-0.8.4
	nix-0.22.3
	nix-0.24.2
	nom-7.1.1
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	once_cell-1.13.1
	opaque-debug-0.3.0
	os_str_bytes-6.3.0
	output_vt100-0.1.3
	parking_lot-0.12.1
	parking_lot_core-0.9.3
	pkg-config-0.3.25
	pretty_assertions-1.2.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.43
	quick-xml-0.22.0
	quote-1.0.21
	redox_syscall-0.2.16
	redox_users-0.4.3
	rust-embed-6.4.0
	rust-embed-impl-6.2.0
	rust-embed-utils-7.2.0
	ryu-1.0.11
	same-file-1.0.6
	scoped-tls-1.0.0
	scopeguard-1.1.0
	serde-1.0.143
	serde_derive-1.0.143
	serde_json-1.0.83
	sha2-0.9.9
	shellexpand-2.1.2
	signal-hook-0.3.14
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.0
	smallvec-1.9.0
	smithay-client-toolkit-0.16.0
	smithay-clipboard-0.6.6
	static_assertions-1.1.0
	strsim-0.10.0
	syn-1.0.99
	termcolor-1.1.3
	terminal_size-0.1.17
	textwrap-0.15.0
	thiserror-1.0.32
	thiserror-impl-1.0.32
	time-0.1.44
	tinytemplate-1.2.1
	toml-0.5.9
	tui-0.19.0
	typenum-1.15.0
	unicode-ident-1.0.3
	unicode-segmentation-1.9.0
	unicode-width-0.1.9
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.82
	wasm-bindgen-backend-0.2.82
	wasm-bindgen-macro-0.2.82
	wasm-bindgen-macro-support-0.2.82
	wasm-bindgen-shared-0.2.82
	wayland-client-0.29.4
	wayland-commons-0.29.4
	wayland-cursor-0.29.4
	wayland-protocols-0.29.4
	wayland-scanner-0.29.4
	wayland-sys-0.29.4
	which-4.2.5
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
	winreg-0.7.0
	winreg-0.9.0
	x11-clipboard-0.6.1
	xcb-1.1.1
	xcursor-0.3.4
	xml-rs-0.8.4
	${P}
"

inherit bash-completion-r1 cargo

DESCRIPTION="Terminal User Interface for GnuPG"
HOMEPAGE="
	https://crates.io/crates/gpg-tui
	https://github.com/orhun/gpg-tui
"
SRC_URI="
	$(cargo_crate_uris ${CRATES})
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