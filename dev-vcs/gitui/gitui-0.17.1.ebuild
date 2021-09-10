# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

AG_PV="${PV}"

CRATES="
	addr2line-0.16.0
	adler-1.0.2
	ahash-0.7.4
	aho-corasick-0.7.18
	ansi_term-0.12.1
	anyhow-1.0.43
	arrayvec-0.4.12
	atty-0.2.14
	autocfg-1.0.1
	backtrace-0.3.61
	base64-0.13.0
	bincode-1.3.3
	bit-set-0.5.2
	bit-vec-0.6.3
	bitflags-1.2.1
	bugreport-0.4.1
	bytemuck-1.7.2
	bytesize-1.1.0
	cassowary-0.3.0
	cc-1.0.70
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.33.3
	cpp_demangle-0.3.3
	crc32fast-1.2.1
	crossbeam-channel-0.5.1
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.5
	crossbeam-utils-0.8.5
	crossterm-0.20.0
	crossterm_winapi-0.8.0
	ctor-0.1.21
	debugid-0.7.2
	diff-0.1.12
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	easy-cast-0.4.4
	either-1.6.1
	fancy-regex-0.7.1
	filetreelist-0.3.0
	flate2-1.0.21
	fnv-1.0.7
	form_urlencoded-1.0.1
	fuzzy-matcher-0.3.7
	getrandom-0.2.3
	gh-emoji-1.0.6
	gimli-0.25.0
	git-version-0.3.5
	git-version-macro-0.3.5
	git2-0.13.22
	hashbrown-0.11.2
	hermit-abi-0.1.19
	idna-0.2.3
	indexmap-1.7.0
	inferno-0.10.7
	instant-0.1.10
	itertools-0.10.1
	itoa-0.4.8
	jobserver-0.1.24
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.101
	libgit2-sys-0.12.23+1.2.0
	libssh2-sys-0.2.21
	libz-sys-1.1.3
	line-wrap-0.1.1
	linked-hash-map-0.5.4
	lock_api-0.4.5
	log-0.4.14
	matches-0.1.9
	memchr-2.4.1
	memmap-0.7.0
	memoffset-0.6.4
	miniz_oxide-0.4.4
	mio-0.7.13
	miow-0.3.7
	nix-0.20.1
	nodrop-0.1.14
	ntapi-0.3.6
	num-format-0.4.0
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	object-0.26.2
	once_cell-1.8.0
	openssl-probe-0.1.4
	openssl-src-111.16.0+1.1.1l
	openssl-sys-0.9.66
	output_vt100-0.1.2
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	percent-encoding-2.1.0
	phf-0.10.0
	phf_shared-0.10.0
	pkg-config-0.3.19
	plist-1.2.1
	pprof-0.5.0
	ppv-lite86-0.2.10
	pretty_assertions-0.7.2
	proc-macro-hack-0.5.19
	proc-macro2-1.0.29
	quick-xml-0.22.0
	quote-1.0.9
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	rayon-core-1.9.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	rgb-0.8.27
	ron-0.6.4
	rustc-demangle-0.1.21
	ryu-1.0.5
	safemem-0.3.3
	same-file-1.0.6
	scopeguard-1.1.0
	scopetime-0.1.1
	serde-1.0.130
	serde_derive-1.0.130
	serde_json-1.0.67
	shell-escape-0.1.5
	signal-hook-0.3.10
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	simplelog-0.10.0
	siphasher-0.3.7
	smallvec-1.6.1
	smawk-0.3.1
	stable_deref_trait-1.2.0
	str_stack-0.1.0
	symbolic-common-8.3.0
	symbolic-demangle-8.3.0
	syn-1.0.76
	syntect-4.6.0
	sys-info-0.9.0
	tempfile-3.2.0
	textwrap-0.11.0
	textwrap-0.14.2
	thiserror-1.0.29
	thiserror-impl-1.0.29
	thread_local-1.1.3
	time-0.1.43
	tinyvec-1.3.1
	tinyvec_macros-0.1.0
	tui-0.16.0
	unicode-bidi-0.3.6
	unicode-linebreak-0.1.2
	unicode-normalization-0.1.19
	unicode-segmentation-1.8.0
	unicode-truncate-0.2.0
	unicode-width-0.1.8
	unicode-xid-0.2.2
	url-2.2.2
	uuid-0.8.2
	vcpkg-0.2.15
	version_check-0.9.3
	walkdir-2.3.2
	wasi-0.10.2+wasi-snapshot-preview1
	which-4.2.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	xml-rs-0.8.4
	yaml-rust-0.4.5
	asyncgit-${AG_PV}
	${P}
"

inherit cargo flag-o-matic

DESCRIPTION="Blazing fast terminal-ui for git"
HOMEPAGE="
	https://crates.io/crates/gitui
	https://github.com/extrawurst/gitui
"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="BSD Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nerd trace-libgit"

RDEPEND="
	>=dev-libs/libgit2-1.2.0
	trace-libgit? ( dev-libs/libgit2[trace(+)] )

	dev-libs/openssl
"
DEPEND="${RDEPEND}"

RESTRICT="mirror"

src_prepare() {
	(
		# https://github.com/extrawurst/gitui/issues/459
		#   `vendored-openssl` is for portability and static linking,
		#   wich we are don't use
		set -e

		cd "${CARGO_HOME}"
		source="$(sed -n '/^replace-with/{s/.*"\(.*\)"$/\1/p;q}' <./config)"
		sed -i "./${source}/asyncgit-${AG_PV}/Cargo.toml" \
			-e '/"vendored[^"]*"/d'
	) || die 'failed to `sed` asyncgit'

	if use nerd; then
		sed -i "${S}/src/keys.rs" \
			-e 's/\\u{238b}/ESC/' \
			-e 's/\\u{2325}/M^/' \
			-e 's/23ce/f810/' \
			-e 's/232b/f56d/' \
			-e 's/2912/f015/' \
			-e 's/2913/fb00/' \
			-e 's/21de/f077/' \
			-e 's/21df/f078/' \
			-e 's/2326/fae7/' \
			-e 's/2380/0049/'
	fi || die

	filter-flags -flto*  # building fails when compiling with LTO

	use trace-libgit || {
		sed -i src/main.rs \
			-e '/register_tracing_logging/d' \
		|| die
	}

	default
}

src_install() {
	local DOCS=( {README,KEY_CONFIG,THEMES}.md )

	dobin "target/release/${PN}"

	insinto "/usr/share/${P}/examples"
	doins   vim_style_key_config.ron

	einstalldocs
}

pkg_postinst() {
	einfo "Example of vim keybindings config stored in '/usr/share/${P}/examples'"
	einfo 'to use it put example config in `$XDG_CONFIG_HOME/gitui/key_config.ron`'
}
