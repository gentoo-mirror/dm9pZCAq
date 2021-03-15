# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
addr2line-0.14.1
adler-1.0.2
ahash-0.6.3
anyhow-1.0.38
arrayvec-0.4.12
atty-0.2.14
autocfg-1.0.1
backtrace-0.3.56
base64-0.13.0
bitflags-1.2.1
bytemuck-1.5.1
bytesize-1.0.1
cassowary-0.3.0
cc-1.0.67
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
cpp_demangle-0.3.2
crossbeam-channel-0.5.0
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.3
crossbeam-utils-0.8.3
crossterm-0.18.2
crossterm-0.19.0
crossterm_winapi-0.6.2
crossterm_winapi-0.7.0
debugid-0.7.2
dirs-next-2.0.0
dirs-sys-next-0.1.2
either-1.6.1
form_urlencoded-1.0.1
getrandom-0.2.2
gimli-0.23.0
git2-0.13.17
glob-0.3.0
hashbrown-0.9.1
hermit-abi-0.1.18
idna-0.2.2
indexmap-1.6.2
inferno-0.10.3
instant-0.1.9
invalidstring-0.1.2
itertools-0.10.0
itoa-0.4.7
jobserver-0.1.21
lazy_static-1.4.0
libc-0.2.88
libgit2-sys-0.12.18+1.1.0
libssh2-sys-0.2.21
libz-sys-1.1.2
lock_api-0.4.2
log-0.4.14
matches-0.1.8
memchr-2.3.4
memmap-0.7.0
memoffset-0.6.1
miniz_oxide-0.4.4
mio-0.7.9
miow-0.3.6
nix-0.19.1
nodrop-0.1.14
ntapi-0.3.6
num-format-0.4.0
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.0
object-0.23.0
once_cell-1.7.2
openssl-probe-0.1.2
openssl-src-111.14.0+1.1.1j
openssl-sys-0.9.60
parking_lot-0.11.1
parking_lot_core-0.8.3
percent-encoding-2.1.0
pkg-config-0.3.19
pprof-0.4.2
ppv-lite86-0.2.10
proc-macro2-1.0.24
quick-xml-0.20.0
quote-1.0.9
rand-0.8.3
rand_chacha-0.3.0
rand_core-0.6.2
rand_hc-0.3.0
rayon-core-1.9.0
redox_syscall-0.2.5
redox_users-0.4.0
remove_dir_all-0.5.3
rgb-0.8.25
ron-0.6.4
rustc-demangle-0.1.18
scopeguard-1.1.0
scopetime-0.1.1
serde-1.0.124
serde_derive-1.0.124
serial_test-0.5.1
serial_test_derive-0.5.1
signal-hook-0.1.17
signal-hook-registry-1.3.0
simplelog-0.9.0
smallvec-1.6.1
smawk-0.3.1
socket2-0.3.19
stable_deref_trait-1.2.0
str_stack-0.1.0
symbolic-common-8.0.5
symbolic-demangle-8.0.5
syn-1.0.63
tempfile-3.2.0
textwrap-0.11.0
textwrap-0.13.4
thiserror-1.0.24
thiserror-impl-1.0.24
time-0.1.43
tinyvec-1.1.1
tinyvec_macros-0.1.0
tui-0.14.0
unicode-bidi-0.3.4
unicode-normalization-0.1.17
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
url-2.2.1
uuid-0.8.2
vcpkg-0.2.11
version_check-0.9.2
wasi-0.10.2+wasi-snapshot-preview1
which-4.0.2
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
asyncgit-${PV}
${P}
"

inherit cargo flag-o-matic

DESCRIPTION="Blazing fast terminal-ui for git"
HOMEPAGE="https://github.com/extrawurst/gitui"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="BSD Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="dev-libs/libgit2"
RDEPEND="${DEPEND}"

IUSE="nerd"

RESTRICT="mirror"

src_prepare() {
	(
		# https://github.com/extrawurst/gitui/issues/459
		#   `vendored-openssl` is for portability and static linking,
		#   wich we are don't use
		set -e

		cd "${CARGO_HOME}"
		source="$(sed -n '/^replace-with/{s/.*"\(.*\)"$/\1/p;q}' <./config)"
		sed -i "./${source}/asyncgit-${PV}/Cargo.toml" \
			-e '/"vendored-openssl"/d'
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
