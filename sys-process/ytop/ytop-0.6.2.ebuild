# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
ansi_term-0.11.0
arc-swap-0.4.6
arrayref-0.3.6
arrayvec-0.5.1
atty-0.2.14
autocfg-1.0.0
backtrace-0.3.46
backtrace-sys-0.1.37
base64-0.11.0
battery-0.7.5
better-panic-0.2.0
bitflags-1.2.1
blake2b_simd-0.5.10
cassowary-0.3.0
cc-1.0.52
cfg-if-0.1.10
chrono-0.4.11
clap-2.33.0
clicolors-control-1.0.1
cloudabi-0.0.3
console-0.9.2
constant_time_eq-0.1.5
core-foundation-0.6.4
core-foundation-sys-0.6.2
crossbeam-channel-0.4.2
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.1
crossbeam-utils-0.7.2
crossterm-0.17.4
crossterm_winapi-0.6.1
ctrlc-3.1.4
darwin-libproc-0.1.2
darwin-libproc-sys-0.1.2
derive_more-0.99.5
dirs-2.0.2
dirs-sys-0.3.4
doc-comment-0.3.3
either-1.5.3
encode_unicode-0.3.6
fern-0.6.0
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
getrandom-0.1.14
glob-0.3.0
heck-0.3.1
hermit-abi-0.1.12
iovec-0.1.4
itertools-0.9.0
itoa-0.4.5
kernel32-sys-0.2.2
lazy_static-1.4.0
lazycell-1.2.1
libc-0.2.69
lock_api-0.3.4
log-0.4.8
mach-0.2.3
mach-0.3.2
maybe-uninit-2.0.0
memchr-2.3.3
memoffset-0.5.4
mio-0.6.22
miow-0.2.1
net2-0.2.34
nix-0.15.0
nix-0.17.0
ntapi-0.3.4
num-bigint-0.2.6
num-integer-0.1.42
num-rational-0.2.4
num-traits-0.2.11
num_cpus-1.13.0
once_cell-1.3.1
parking_lot-0.10.2
parking_lot_core-0.7.2
platform-dirs-0.2.0
platforms-0.2.1
proc-macro-error-1.0.2
proc-macro-error-attr-1.0.2
proc-macro2-1.0.12
psutil-3.1.0
quote-1.0.4
rayon-1.3.0
rayon-core-1.7.0
redox_syscall-0.1.56
redox_users-0.3.4
regex-1.3.7
regex-syntax-0.6.17
rust-argon2-0.7.0
rustc-demangle-0.1.16
ryu-1.0.4
scopeguard-1.1.0
serde-1.0.110
serde_derive-1.0.110
serde_json-1.0.53
signal-hook-0.1.14
signal-hook-registry-1.2.0
size-0.1.2
slab-0.4.2
smallvec-1.4.0
snafu-0.6.7
snafu-derive-0.6.7
strsim-0.8.0
structopt-0.3.14
structopt-derive-0.4.7
syn-1.0.19
syn-mid-0.5.0
sysinfo-0.14.1
termios-0.3.2
textwrap-0.11.0
time-0.1.43
tui-0.9.2
typenum-1.12.0
unescape-0.1.0
unicode-segmentation-1.6.0
unicode-width-0.1.7
unicode-xid-0.2.0
uom-0.26.0
vec_map-0.8.2
version_check-0.9.1
void-1.0.2
wasi-0.9.0+wasi-snapshot-preview1
winapi-0.2.8
winapi-0.3.8
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
ws2_32-sys-0.2.1
${P}
"

inherit cargo flag-o-matic

DESCRIPTION="A TUI system monitor written in Rust"
HOMEPAGE="
	https://crates.io/crates/ytop
	https://github.com/cjbassi/ytop
"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"

LICENSE="MIT Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 CC0-1.0 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	filter-flags -flto*  # building fails when compiling with LTO

	cargo_src_compile
}
