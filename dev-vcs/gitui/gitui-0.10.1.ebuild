# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
libc-0.2.72
autocfg-1.0.0
cfg-if-0.1.10
log-0.4.11
proc-macro2-1.0.18
unicode-xid-0.2.1
syn-1.0.33
pkg-config-0.3.17
bitflags-1.2.1
lazy_static-1.4.0
scopeguard-1.1.0
serde_derive-1.0.115
maybe-uninit-2.0.0
serde-1.0.115
matches-0.1.8
tinyvec-0.3.3
arc-swap-0.4.7
smallvec-1.4.1
unicode-width-0.1.8
percent-encoding-2.1.0
rayon-core-1.8.0
gimli-0.22.0
either-1.5.3
anyhow-1.0.32
adler-0.2.2
cassowary-0.3.0
base64-0.12.3
unicode-segmentation-1.6.0
object-0.20.0
rustc-demangle-0.1.16
bytesize-1.0.1
lock_api-0.3.4
lock_api-0.4.1
unicode-bidi-0.3.4
textwrap-0.11.0
textwrap-0.12.1
unicode-normalization-0.1.13
miniz_oxide-0.4.0
itertools-0.9.0
crossbeam-utils-0.7.2
memoffset-0.5.5
crossbeam-epoch-0.8.2
num-traits-0.2.12
num-integer-0.1.43
idna-0.2.0
clap-2.33.3
quote-1.0.7
jobserver-0.1.21
parking_lot_core-0.7.2
parking_lot_core-0.8.0
signal-hook-registry-1.2.0
mio-0.7.0
num_cpus-1.13.0
time-0.1.43
dirs-sys-0.3.5
xcb-0.8.2
url-2.1.1
crossbeam-channel-0.4.3
addr2line-0.13.0
cc-1.0.58
parking_lot-0.10.2
parking_lot-0.11.0
signal-hook-0.1.16
dirs-3.0.1
crossbeam-deque-0.7.3
backtrace-0.3.50
chrono-0.4.15
simplelog-0.8.0
x11-clipboard-0.3.3
clipboard-0.5.0
libz-sys-1.1.0
libgit2-sys-0.12.12+1.0.1
git2-0.13.10
thiserror-impl-1.0.20
thiserror-1.0.20
crossterm-0.17.7
ron-0.6.1
tui-0.9.5
tempfile-3.1.0
pprof-0.3.18
rand-0.7.3
remove_dir_all-0.5.3
redox_syscall-0.1.56
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
objc-foundation-0.1.1
objc_id-0.1.1
objc-0.2.7
clipboard-win-2.2.0
crossterm_winapi-0.6.1
inferno-0.10.0
nix-0.17.0
symbolic-demangle-7.4.0
hermit-abi-0.1.15
getrandom-0.1.14
rand_core-0.5.1
rand_chacha-0.2.2
rand_hc-0.2.0
malloc_buf-0.0.6
block-0.1.6
miow-0.3.5
ntapi-0.3.4
redox_users-0.3.4
ahash-0.3.8
indexmap-1.4.0
itoa-0.4.6
num-format-0.4.0
quick-xml-0.18.1
rgb-0.8.20
str_stack-0.1.0
void-1.0.2
instant-0.1.6
cpp_demangle-0.3.0
msvc-demangler-0.8.0
symbolic-common-7.4.0
vcpkg-0.2.10
wasi-0.9.0+wasi-snapshot-preview1
ppv-lite86-0.2.8
cloudabi-0.0.3
cloudabi-0.1.0
socket2-0.3.12
rust-argon2-0.7.0
const-random-0.1.8
base64-0.11.0
uuid-0.8.1
stable_deref_trait-1.1.1
memmap-0.7.0
failure-0.1.8
failure_derive-0.1.8
debugid-0.7.2
glob-0.3.0
bytemuck-1.2.0
memchr-2.3.3
arrayvec-0.4.12
arrayvec-0.5.1
synstructure-0.12.4
arrayref-0.3.6
nodrop-0.1.14
proc-macro-hack-0.5.16
const-random-macro-0.1.8
constant_time_eq-0.1.5
blake2b_simd-0.5.10
"

inherit cargo

DESCRIPTION="Blazing fast terminal-ui for git"
HOMEPAGE="https://github.com/extrawurst/gitui"
SRC_URI="$(cargo_crate_uris ${CRATES})
	https://github.com/extrawurst/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"

RESTRICT="mirror"

LICENSE="BSD Apache-2.0 BSD-with-disclosure CC0-1.0 MIT ZLIB"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="nerd"

src_prepare() {
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
	fi || die 'sed failed'

	default
}

src_install() {
	insinto "/usr/share/${P}/examples"
	doins   "${S}/assets/vim_style_key_config.ron"

	dodoc README.md KEY_CONFIG.md THEMES.md

	cargo_src_install
}

pkg_postinst() {
	elog "Example of vim keybindings config stored in '/usr/share/${P}/examples'"
	elog 'to use it put example config in `$XDG_CONFIG_HOME/gitui/key_config.ron`'
}
