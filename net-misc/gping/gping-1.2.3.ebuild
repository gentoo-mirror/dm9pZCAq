# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	aho-corasick-0.7.18
	ansi_term-0.11.0
	anyhow-1.0.42
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.2.1
	cassowary-0.3.0
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.33.3
	crossterm-0.19.0
	crossterm-0.20.0
	crossterm_winapi-0.7.0
	crossterm_winapi-0.8.0
	dns-lookup-1.0.8
	either-1.6.1
	heck-0.3.2
	hermit-abi-0.1.18
	instant-0.1.9
	itertools-0.10.1
	lazy_static-1.4.0
	libc-0.2.88
	lock_api-0.4.2
	log-0.4.14
	memchr-2.4.0
	mio-0.7.9
	miow-0.3.6
	ntapi-0.3.6
	num-integer-0.1.44
	num-traits-0.2.14
	os_info-3.0.6
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	pinger-0.3.4
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.24
	quote-1.0.9
	redox_syscall-0.2.5
	regex-1.5.4
	regex-syntax-0.6.25
	scopeguard-1.1.0
	signal-hook-0.1.17
	signal-hook-0.3.9
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	smallvec-1.6.1
	socket2-0.3.19
	socket2-0.4.0
	static_assertions-1.1.0
	strsim-0.8.0
	structopt-0.3.22
	structopt-derive-0.4.15
	syn-1.0.62
	textwrap-0.11.0
	thiserror-1.0.26
	thiserror-impl-1.0.26
	time-0.1.44
	tui-0.15.0
	unicode-segmentation-1.7.1
	unicode-width-0.1.8
	unicode-xid-0.2.1
	vec_map-0.8.2
	version_check-0.9.2
	wasi-0.10.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	winapi_forked_icmpapi-0.3.7
	winping-0.10.1
	${P}
"

inherit cargo

DESCRIPTION="Ping, but with a graph"

HOMEPAGE="
	https://github.com/orf/gping
	https://crates.io/crates/gping
"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"

LICENSE="Apache-2.0 BSD-2 MIT Unlicense"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
