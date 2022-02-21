# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ansi_term-0.12.1
	anyhow-1.0.53
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	block-0.1.6
	block-buffer-0.9.0
	bytemuck-1.7.3
	byteorder-1.4.3
	cassowary-0.3.0
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.4.19
	clap-3.1.0
	clap_complete-3.1.0
	clap_derive-3.1.0
	clipboard-win-3.1.1
	color_quant-1.1.0
	colorsys-0.6.5
	conv-0.3.3
	copypasta-0.7.1
	copypasta-ext-0.3.7
	cpufeatures-0.2.1
	crossterm-0.22.1
	crossterm-0.23.0
	crossterm_winapi-0.9.0
	cstr-argument-0.1.2
	ctor-0.1.21
	custom_derive-0.1.7
	diff-0.1.12
	digest-0.9.0
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	dlib-0.5.0
	downcast-rs-1.2.0
	either-1.6.1
	generic-array-0.14.5
	getrandom-0.2.4
	gpg-error-0.5.2
	gpgme-0.10.0
	gpgme-sys-0.10.0
	hashbrown-0.11.2
	heck-0.4.0
	hermit-abi-0.1.19
	hex-literal-0.3.4
	image-0.24.0
	indexmap-1.8.0
	instant-0.1.12
	itoa-1.0.1
	jpeg-decoder-0.2.2
	lazy-bytes-cast-5.0.1
	lazy_static-1.4.0
	libc-0.2.118
	libgpg-error-sys-0.5.2
	libloading-0.7.3
	lock_api-0.4.6
	log-0.4.14
	malloc_buf-0.0.6
	memchr-2.4.1
	memmap2-0.3.1
	memoffset-0.6.5
	minimal-lexical-0.2.1
	mio-0.7.14
	miow-0.3.7
	nix-0.22.3
	nom-7.1.0
	ntapi-0.3.7
	num-integer-0.1.44
	num-iter-0.1.42
	num-rational-0.4.0
	num-traits-0.2.14
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	once_cell-1.9.0
	opaque-debug-0.3.0
	os_str_bytes-6.0.0
	output_vt100-0.1.3
	parking_lot-0.11.2
	parking_lot-0.12.0
	parking_lot_core-0.8.5
	parking_lot_core-0.9.1
	pkg-config-0.3.24
	pretty_assertions-1.1.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.36
	quick-xml-0.22.0
	quote-1.0.15
	redox_syscall-0.2.10
	redox_users-0.4.0
	rust-embed-6.3.0
	rust-embed-impl-6.2.0
	rust-embed-utils-7.1.0
	ryu-1.0.9
	same-file-1.0.6
	scoped-tls-1.0.0
	scopeguard-1.1.0
	serde-1.0.136
	serde_derive-1.0.136
	serde_json-1.0.79
	sha2-0.9.9
	shellexpand-2.1.0
	signal-hook-0.3.13
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	smallvec-1.8.0
	smithay-client-toolkit-0.15.3
	smithay-clipboard-0.6.5
	static_assertions-1.1.0
	strsim-0.10.0
	syn-1.0.86
	termcolor-1.1.2
	terminal_size-0.1.17
	textwrap-0.14.2
	time-0.1.44
	tinytemplate-1.2.1
	toml-0.5.8
	tui-0.17.0
	typenum-1.15.0
	unicode-segmentation-1.9.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.10.0+wasi-snapshot-preview1
	wayland-client-0.29.4
	wayland-commons-0.29.4
	wayland-cursor-0.29.4
	wayland-protocols-0.29.4
	wayland-scanner-0.29.4
	wayland-sys-0.29.4
	which-4.2.4
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.32.0
	windows_aarch64_msvc-0.32.0
	windows_i686_gnu-0.32.0
	windows_i686_msvc-0.32.0
	windows_x86_64_gnu-0.32.0
	windows_x86_64_msvc-0.32.0
	winreg-0.7.0
	winreg-0.9.0
	x11-clipboard-0.5.3
	xcb-0.10.1
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
