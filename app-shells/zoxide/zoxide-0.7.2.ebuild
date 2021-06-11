# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
anyhow-1.0.40
arrayvec-0.5.2
askama-0.10.5
askama_derive-0.10.5
askama_escape-0.10.1
askama_shared-0.11.1
assert_cmd-1.0.5
atty-0.2.14
autocfg-1.0.1
bincode-1.3.3
bitflags-1.2.1
bitvec-0.19.5
bstr-0.2.16
cfg-if-1.0.0
clap-3.0.0-beta.2
clap_derive-3.0.0-beta.2
clap_generate-3.0.0-beta.2
difference-2.0.0
dirs-next-2.0.0
dirs-sys-next-0.1.2
doc-comment-0.3.3
dunce-1.0.2
funty-1.1.0
getrandom-0.1.16
getrandom-0.2.3
glob-0.3.0
hashbrown-0.9.1
heck-0.3.3
hermit-abi-0.1.18
indexmap-1.6.2
lazy_static-1.4.0
lexical-core-0.7.6
libc-0.2.96
memchr-2.4.0
nom-6.1.2
num-traits-0.2.14
ordered-float-2.5.1
os_str_bytes-2.4.0
pest-2.1.3
ppv-lite86-0.2.10
predicates-1.0.8
predicates-core-1.0.2
predicates-tree-1.0.2
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.27
quote-1.0.9
radium-0.5.3
rand-0.7.3
rand-0.8.3
rand_chacha-0.2.2
rand_chacha-0.3.1
rand_core-0.5.1
rand_core-0.6.2
rand_hc-0.2.0
rand_hc-0.3.0
redox_syscall-0.2.8
redox_users-0.4.0
regex-automata-0.1.10
remove_dir_all-0.5.3
rstest-0.10.0
rustc_version-0.3.3
ryu-1.0.5
semver-0.11.0
semver-parser-0.10.2
serde-1.0.126
serde_derive-1.0.126
static_assertions-1.1.0
strsim-0.10.0
syn-1.0.73
tap-1.0.1
tempfile-3.2.0
termcolor-1.1.2
textwrap-0.12.1
treeline-0.1.0
ucd-trie-0.1.3
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.2
vec_map-0.8.2
version_check-0.9.3
wait-timeout-0.2.0
wasi-0.9.0+wasi-snapshot-preview1
wasi-0.10.2+wasi-snapshot-preview1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
wyz-0.2.0
${P}
"

inherit cargo

DESCRIPTION="A smarter cd command"
HOMEPAGE="
	https://crates.io/crates/zoxide
	https://github.com/ajeetdsouza/zoxide
"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"

LICENSE="Apache-2.0 CC0-1.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

src_install() {
	local DOCS=( README.md )

	doman man/*
	einstalldocs

	dobin "target/release/${PN}"
}
