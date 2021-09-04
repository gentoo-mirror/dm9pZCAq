# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	ansi_term-0.11.0
	ansi_term-0.12.1
	anyhow-1.0.43
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.3.2
	block-0.1.6
	block-buffer-0.9.0
	bytemuck-1.7.2
	byteorder-1.4.3
	cassowary-0.3.0
	cc-1.0.70
	cfg-if-0.1.10
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.33.3
	clipboard-win-3.1.1
	color_quant-1.1.0
	colorsys-0.6.4
	conv-0.3.3
	copypasta-0.7.1
	copypasta-ext-0.3.7
	cpufeatures-0.2.1
	crossterm-0.20.0
	crossterm-0.21.0
	crossterm_winapi-0.8.0
	cstr-argument-0.1.1
	ctor-0.1.21
	custom_derive-0.1.7
	diff-0.1.12
	digest-0.9.0
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	dlib-0.5.0
	downcast-rs-1.2.0
	either-1.6.1
	generic-array-0.14.4
	getrandom-0.2.3
	gpg-error-0.5.2
	gpgme-0.10.0
	gpgme-sys-0.10.0
	heck-0.3.3
	hermit-abi-0.1.19
	hex-literal-0.3.3
	image-0.23.14
	instant-0.1.10
	jpeg-decoder-0.1.22
	lazy-bytes-cast-5.0.1
	lazy_static-1.4.0
	libc-0.2.101
	libgpg-error-sys-0.5.2
	libloading-0.7.0
	lock_api-0.4.5
	log-0.4.14
	malloc_buf-0.0.6
	memchr-2.4.1
	memmap2-0.2.3
	minimal-lexical-0.1.2
	mio-0.7.13
	miow-0.3.7
	nix-0.20.0
	nom-7.0.0
	ntapi-0.3.6
	num-integer-0.1.44
	num-iter-0.1.42
	num-rational-0.3.2
	num-traits-0.2.14
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	once_cell-1.8.0
	opaque-debug-0.3.0
	output_vt100-0.1.2
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	pkg-config-0.3.19
	pretty_assertions-0.7.2
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.29
	quote-1.0.9
	redox_syscall-0.2.10
	redox_users-0.4.0
	rust-embed-6.2.0
	rust-embed-impl-6.1.0
	rust-embed-utils-7.0.0
	same-file-1.0.6
	scoped-tls-1.0.0
	scopeguard-1.1.0
	serde-1.0.130
	serde_derive-1.0.130
	sha2-0.9.6
	shellexpand-2.1.0
	signal-hook-0.3.10
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	smallvec-1.6.1
	smithay-client-toolkit-0.14.0
	smithay-clipboard-0.6.4
	static_assertions-1.1.0
	strsim-0.8.0
	structopt-0.3.23
	structopt-derive-0.4.16
	syn-1.0.75
	term_size-0.3.2
	textwrap-0.11.0
	time-0.1.44
	toml-0.5.8
	tui-0.16.0
	typenum-1.13.0
	unicode-segmentation-1.8.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	version_check-0.9.3
	walkdir-2.3.2
	wasi-0.10.0+wasi-snapshot-preview1
	wayland-client-0.28.6
	wayland-commons-0.28.6
	wayland-cursor-0.28.6
	wayland-protocols-0.28.6
	wayland-scanner-0.28.6
	wayland-sys-0.28.6
	which-4.2.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winreg-0.7.0
	winreg-0.9.0
	x11-clipboard-0.5.2
	xcb-0.9.0
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

	cp -v -- "${DISTDIR}/${P}.man.1" "${S}/${PN}.1" || die
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
	doman "${PN}.1"

	dobin "target/release/${PN}"

	# bash-completion
	newbashcomp "completions/${PN}.bash" "${PN}"

	# zsh-completion
	insinto /usr/share/zsh/site-functions
	doins "completions/_${PN}"

	# fish-completion
	insinto /usr/share/fish/vendor_completions.d
	doins "completions/${PN}.fish"
}
