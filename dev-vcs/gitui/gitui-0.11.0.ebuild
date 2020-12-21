# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
addr2line-0.14.0
adler-0.2.3
ahash-0.6.1
anyhow-1.0.35
arrayvec-0.4.12
asyncgit-0.11.0
autocfg-1.0.1
backtrace-0.3.55
base64-0.12.3
bitflags-1.2.1
bytemuck-1.4.1
bytesize-1.0.1
cassowary-0.3.0
cc-1.0.66
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
const_fn-0.4.3
cpp_demangle-0.3.2
crossbeam-channel-0.5.0
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.1
crossbeam-utils-0.8.1
crossterm-0.18.2
crossterm_winapi-0.6.2
debugid-0.7.2
dirs-next-2.0.0
dirs-sys-next-0.1.1
either-1.6.1
form_urlencoded-1.0.0
getrandom-0.1.15
getrandom-0.2.0
gimli-0.23.0
git2-0.13.12
gitui-0.11.0
glob-0.3.0
hashbrown-0.9.1
hermit-abi-0.1.17
idna-0.2.0
indexmap-1.6.0
inferno-0.10.2
instant-0.1.9
invalidstring-0.1.2
itertools-0.9.0
itoa-0.4.6
jobserver-0.1.21
lazy_static-1.4.0
libc-0.2.81
libgit2-sys-0.12.14+1.1.0
libssh2-sys-0.2.20
libz-sys-1.1.2
lock_api-0.4.2
log-0.4.11
matches-0.1.8
memchr-2.3.4
memmap-0.7.0
memoffset-0.6.1
miniz_oxide-0.4.3
mio-0.7.6
miow-0.3.6
nix-0.17.0
nodrop-0.1.14
ntapi-0.3.6
num-format-0.4.0
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.0
object-0.22.0
openssl-probe-0.1.2
openssl-sys-0.9.58
parking_lot-0.11.1
parking_lot_core-0.8.1
percent-encoding-2.1.0
pkg-config-0.3.19
pprof-0.3.20
ppv-lite86-0.2.10
proc-macro2-1.0.24
quick-xml-0.20.0
quote-1.0.7
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_hc-0.2.0
rayon-core-1.9.0
redox_syscall-0.1.57
redox_users-0.3.5
remove_dir_all-0.5.3
rgb-0.8.25
ron-0.6.3
rustc-demangle-0.1.18
scopeguard-1.1.0
scopetime-0.1.1
serde-1.0.118
serde_derive-1.0.118
serial_test-0.5.1
serial_test_derive-0.5.1
signal-hook-0.1.16
signal-hook-registry-1.2.2
simplelog-0.8.0
smallvec-1.5.1
smawk-0.3.0
socket2-0.3.17
stable_deref_trait-1.2.0
str_stack-0.1.0
symbolic-common-8.0.0
symbolic-demangle-8.0.0
syn-1.0.54
tempfile-3.1.0
textwrap-0.11.0
textwrap-0.13.1
thiserror-1.0.22
thiserror-impl-1.0.22
time-0.1.44
tinyvec-1.1.0
tinyvec_macros-0.1.0
tui-0.13.0
unicode-bidi-0.3.4
unicode-normalization-0.1.16
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
url-2.2.0
uuid-0.8.1
vcpkg-0.2.10
version_check-0.9.2
void-1.0.2
wasi-0.9.0+wasi-snapshot-preview1
wasi-0.10.0+wasi-snapshot-preview1
which-4.0.2
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo flag-o-matic

DESCRIPTION="Blazing fast terminal-ui for git"
HOMEPAGE="https://github.com/extrawurst/gitui"
SRC_URI="$(cargo_crate_uris ${CRATES})
	https://github.com/extrawurst/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"

LICENSE="BSD Apache-2.0 BSD-with-disclosure CC0-1.0 MIT ZLIB"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="dev-libs/libgit2"
RDEPEND="${DEPEND}"

IUSE="nerd"

RESTRICT="mirror"

src_prepare() {
	{
		# https://github.com/extrawurst/gitui/issues/459
		#   `vendored-openssl` is for portability and static linking,
		#   wich we are dont use
		sed -i "${S}/asyncgit/Cargo.toml" \
			-e '/^git2/s/"vendored-openssl"//'
	}

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

	filter-flags -flto*  # building fails when compiling with LTO

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
