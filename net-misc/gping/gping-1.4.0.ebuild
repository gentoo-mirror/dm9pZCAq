# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.19
	android_system_properties-0.1.5
	ansi_term-0.12.1
	anyhow-1.0.65
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bumpalo-3.11.0
	cassowary-0.3.0
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.4.22
	clap-2.34.0
	const_fn-0.4.9
	const_format-0.2.26
	const_format_proc_macros-0.2.22
	core-foundation-sys-0.8.3
	crossterm-0.25.0
	crossterm_winapi-0.9.0
	dns-lookup-1.0.8
	either-1.8.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	form_urlencoded-1.1.0
	git2-0.15.0
	heck-0.3.3
	hermit-abi-0.1.19
	iana-time-zone-0.1.48
	idna-0.3.0
	io-lifetimes-0.7.3
	is_debug-1.0.1
	itertools-0.10.4
	itoa-1.0.3
	jobserver-0.1.24
	js-sys-0.3.60
	lazy_static-1.4.0
	libc-0.2.133
	libgit2-sys-0.14.0+1.5.0
	libz-sys-1.1.8
	linux-raw-sys-0.0.46
	lock_api-0.4.8
	log-0.4.17
	memchr-2.5.0
	mio-0.8.4
	num-integer-0.1.45
	num-traits-0.2.15
	num_threads-0.1.6
	once_cell-1.14.0
	parking_lot-0.12.1
	parking_lot_core-0.9.3
	percent-encoding-2.2.0
	pinger-0.5.0
	pkg-config-0.3.25
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.43
	quote-1.0.21
	read_color-1.0.0
	redox_syscall-0.2.16
	regex-1.6.0
	regex-syntax-0.6.27
	rustix-0.35.9
	scopeguard-1.1.0
	shadow-rs-0.16.3
	signal-hook-0.3.14
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.0
	smallvec-1.9.0
	socket2-0.4.7
	static_assertions-1.1.0
	strsim-0.8.0
	structopt-0.3.26
	structopt-derive-0.4.18
	syn-1.0.100
	textwrap-0.11.0
	thiserror-1.0.35
	thiserror-impl-1.0.35
	time-0.1.44
	time-0.3.14
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tui-0.19.0
	tz-rs-0.6.14
	tzdb-0.4.5
	unicode-bidi-0.3.8
	unicode-ident-1.0.4
	unicode-normalization-0.1.22
	unicode-segmentation-1.10.0
	unicode-width-0.1.10
	unicode-xid-0.2.4
	url-2.3.1
	utcnow-0.2.1
	vcpkg-0.2.15
	vec_map-0.8.2
	version_check-0.9.4
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	winapi_forked_icmpapi-0.3.7
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.36.1
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
