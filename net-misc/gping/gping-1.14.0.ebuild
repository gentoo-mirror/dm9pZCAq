# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.0.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.3.2
	anstyle@1.0.1
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	anyhow@1.0.72
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.3.3
	bumpalo@3.13.0
	cassowary@0.3.0
	cc@1.0.79
	cfg-if@1.0.0
	chrono@0.4.26
	clap@4.3.19
	clap_builder@4.3.19
	clap_derive@4.3.12
	clap_lex@0.5.0
	colorchoice@1.0.0
	const_fn@0.4.9
	const_format@0.2.31
	const_format_proc_macros@0.2.31
	core-foundation-sys@0.8.4
	crossterm@0.26.1
	crossterm_winapi@0.9.1
	deranged@0.3.6
	dns-lookup@2.0.2
	either@1.9.0
	errno@0.3.2
	errno-dragonfly@0.1.2
	form_urlencoded@1.2.0
	git2@0.17.2
	heck@0.4.1
	hermit-abi@0.3.2
	iana-time-zone@0.1.57
	iana-time-zone-haiku@0.1.2
	idna@0.4.0
	indoc@2.0.3
	is-terminal@0.4.9
	is_debug@1.0.1
	itertools@0.11.0
	itoa@1.0.9
	jobserver@0.1.26
	js-sys@0.3.64
	lazy_static@1.4.0
	libc@0.2.147
	libgit2-sys@0.15.2+1.6.4
	libz-sys@1.1.12
	linux-raw-sys@0.4.3
	lock_api@0.4.10
	log@0.4.19
	memchr@2.5.0
	mio@0.8.8
	num-traits@0.2.16
	num_threads@0.1.6
	once_cell@1.18.0
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	paste@1.0.14
	percent-encoding@2.3.0
	pinger@0.13.0
	pkg-config@0.3.27
	proc-macro2@1.0.66
	quote@1.0.32
	ratatui@0.22.0
	redox_syscall@0.3.5
	regex@1.9.1
	regex-automata@0.3.4
	regex-syntax@0.7.4
	rustix@0.38.4
	scopeguard@1.2.0
	serde@1.0.179
	shadow-rs@0.23.0
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	smallvec@1.11.0
	socket2@0.5.3
	static_assertions@1.1.0
	strsim@0.10.0
	syn@2.0.28
	thiserror@1.0.44
	thiserror-impl@1.0.44
	time@0.1.45
	time@0.3.24
	time-core@0.1.1
	time-macros@0.2.11
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tz-rs@0.6.14
	tzdb@0.5.7
	unicode-bidi@0.3.13
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unicode-width@0.1.10
	unicode-xid@0.2.4
	url@2.4.0
	utf8parse@0.2.1
	vcpkg@0.2.15
	wasi@0.10.0+wasi-snapshot-preview1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.87
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-shared@0.2.87
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi_forked_icmpapi@0.3.7
	windows@0.48.0
	windows-sys@0.48.0
	windows-targets@0.48.1
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.48.0
	winping@0.10.1
	${PN}@${PV}
"

inherit cargo

DESCRIPTION="Ping, but with a graph"

HOMEPAGE="
	https://github.com/orf/gping
	https://crates.io/crates/gping
"
SRC_URI="${CARGO_CRATE_URIS}"
RESTRICT="mirror"

LICENSE="Apache-2.0 BSD-2 MIT Unlicense"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"