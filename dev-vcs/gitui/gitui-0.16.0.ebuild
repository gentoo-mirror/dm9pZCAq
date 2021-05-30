# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

AG_PV=0.16.1

CRATES="
addr2line-0.15.1
adler-1.0.2
ahash-0.6.3
aho-corasick-0.7.18
ansi_term-0.12.1
anyhow-1.0.40
arrayvec-0.4.12
atty-0.2.14
autocfg-1.0.1
backtrace-0.3.59
base64-0.13.0
bincode-1.3.3
bit-set-0.5.2
bit-vec-0.6.3
bitflags-1.2.1
bugreport-0.4.0
bytemuck-1.5.1
bytesize-1.0.1
cassowary-0.3.0
cc-1.0.67
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
cpp_demangle-0.3.2
crc32fast-1.2.1
crossbeam-channel-0.5.1
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.4
crossbeam-utils-0.8.4
crossterm-0.19.0
crossterm_winapi-0.7.0
ctor-0.1.20
debugid-0.7.2
diff-0.1.12
dirs-next-2.0.0
dirs-sys-next-0.1.2
easy-cast-0.4.4
either-1.6.1
fancy-regex-0.3.5
filetreelist-0.1.1
flate2-1.0.20
fnv-1.0.7
form_urlencoded-1.0.1
getrandom-0.2.3
gimli-0.24.0
git-version-0.3.4
git-version-macro-0.3.4
git2-0.13.20
glob-0.3.0
hashbrown-0.9.1
hermit-abi-0.1.18
idna-0.2.3
indexmap-1.6.2
inferno-0.10.5
instant-0.1.9
invalidstring-0.1.2
itertools-0.10.0
itoa-0.4.7
jobserver-0.1.22
lazy_static-1.4.0
lazycell-1.3.0
libc-0.2.94
libgit2-sys-0.12.21+1.1.0
libssh2-sys-0.2.21
libz-sys-1.1.3
line-wrap-0.1.1
linked-hash-map-0.5.4
lock_api-0.4.4
log-0.4.14
matches-0.1.8
memchr-2.4.0
memmap-0.7.0
memoffset-0.6.3
miniz_oxide-0.4.4
mio-0.7.11
miow-0.3.7
nix-0.20.0
nodrop-0.1.14
ntapi-0.3.6
num-format-0.4.0
num-integer-0.1.44
num-traits-0.2.14
num_cpus-1.13.0
object-0.24.0
once_cell-1.7.2
openssl-probe-0.1.4
openssl-src-111.15.0+1.1.1k
openssl-sys-0.9.63
output_vt100-0.1.2
parking_lot-0.11.1
parking_lot_core-0.8.3
percent-encoding-2.1.0
pkg-config-0.3.19
plist-1.1.0
pprof-0.4.3
ppv-lite86-0.2.10
pretty_assertions-0.7.2
proc-macro-hack-0.5.19
proc-macro2-1.0.27
quick-xml-0.20.0
quote-1.0.9
rand-0.8.3
rand_chacha-0.3.0
rand_core-0.6.2
rand_hc-0.3.0
rayon-core-1.9.1
redox_syscall-0.2.8
redox_users-0.4.0
regex-1.5.4
regex-syntax-0.6.25
remove_dir_all-0.5.3
rgb-0.8.27
ron-0.6.4
rustc-demangle-0.1.19
ryu-1.0.5
safemem-0.3.3
same-file-1.0.6
scopeguard-1.1.0
scopetime-0.1.1
serde-1.0.126
serde_derive-1.0.126
serde_json-1.0.64
serial_test-0.5.1
serial_test_derive-0.5.1
shell-escape-0.1.5
signal-hook-0.1.17
signal-hook-registry-1.3.0
simplelog-0.10.0
smallvec-1.6.1
smawk-0.3.1
stable_deref_trait-1.2.0
str_stack-0.1.0
symbolic-common-8.1.0
symbolic-demangle-8.1.0
syn-1.0.72
syntect-4.5.0
sys-info-0.9.0
tempfile-3.2.0
textwrap-0.11.0
textwrap-0.13.4
thiserror-1.0.25
thiserror-impl-1.0.25
time-0.1.43
tinyvec-1.2.0
tinyvec_macros-0.1.0
tui-0.15.0
unicode-bidi-0.3.5
unicode-normalization-0.1.17
unicode-segmentation-1.7.1
unicode-truncate-0.2.0
unicode-width-0.1.8
unicode-xid-0.2.2
url-2.2.2
uuid-0.8.2
vcpkg-0.2.13
version_check-0.9.3
walkdir-2.3.2
wasi-0.10.2+wasi-snapshot-preview1
which-4.1.0
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
xml-rs-0.8.3
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
KEYWORDS="amd64 ~x86"
IUSE="nerd libressl"

RDEPEND="
	dev-libs/libgit2
	!libressl? ( >=dev-libs/openssl-1.0.1 )
	libressl? (
		>=dev-libs/libressl-2.5.0
		<=dev-libs/libressl-3.3.1
	)
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
	fi || die

	filter-flags -flto*  # building fails when compiling with LTO

	default
}

src_install() {
	local DOCS=( {README,KEY_CONFIG,THEMES}.md )

	insinto "/usr/share/${P}/examples"
	doins   vim_style_key_config.ron

	einstalldocs

	cargo_src_install
}

pkg_postinst() {
	elog "Example of vim keybindings config stored in '/usr/share/${P}/examples'"
	elog 'to use it put example config in `$XDG_CONFIG_HOME/gitui/key_config.ron`'
}
