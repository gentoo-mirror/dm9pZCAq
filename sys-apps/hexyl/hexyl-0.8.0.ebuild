# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
ansi_term-0.11.0
ansi_term-0.12.1
atty-0.2.14
bitflags-1.2.1
clap-2.33.1
hermit-abi-0.1.13
libc-0.2.71
strsim-0.8.0
term_size-0.3.2
textwrap-0.11.0
unicode-width-0.1.7
vec_map-0.8.2
winapi-0.3.8
winapi-i686-pc-windows-gnu-0.4.0
winapi-x86_64-pc-windows-gnu-0.4.0
${P}
"

inherit cargo

DESCRIPTION="A command-line hex viewer"
HOMEPAGE="https://github.com/sharkdp/hexyl"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 MIT Unlicense"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="mirror"
