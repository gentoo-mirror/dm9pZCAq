# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	anyhow-1.0.68
	autocfg-1.1.0
	bitflags-1.3.2
	bumpalo-3.12.0
	cassowary-0.3.0
	cc-1.0.78
	cfg-if-1.0.0
	chrono-0.4.23
	clap-4.1.4
	clap_derive-4.1.0
	clap_lex-0.3.1
	codespan-reporting-0.11.1
	const_fn-0.4.9
	const_format-0.2.30
	const_format_proc_macros-0.2.29
	core-foundation-sys-0.8.3
	crossterm-0.25.0
	crossterm_winapi-0.9.0
	cxx-1.0.88
	cxx-build-1.0.88
	cxxbridge-flags-1.0.88
	cxxbridge-macro-1.0.88
	dns-lookup-1.0.8
	either-1.8.1
	errno-0.2.8
	errno-dragonfly-0.1.2
	form_urlencoded-1.1.0
	git2-0.15.0
	heck-0.4.0
	hermit-abi-0.2.6
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	idna-0.3.0
	io-lifetimes-1.0.4
	is-terminal-0.4.2
	is_debug-1.0.1
	itertools-0.10.5
	itoa-1.0.5
	jobserver-0.1.25
	js-sys-0.3.60
	lazy_static-1.4.0
	libc-0.2.139
	libgit2-sys-0.14.2+1.5.1
	libz-sys-1.1.8
	link-cplusplus-1.0.8
	linux-raw-sys-0.1.4
	lock_api-0.4.9
	log-0.4.17
	memchr-2.5.0
	mio-0.8.5
	num-integer-0.1.45
	num-traits-0.2.15
	num_threads-0.1.6
	once_cell-1.17.0
	os_str_bytes-6.4.1
	parking_lot-0.12.1
	parking_lot_core-0.9.6
	percent-encoding-2.2.0
	pinger-0.8.0
	pkg-config-0.3.26
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.50
	quote-1.0.23
	read_color-1.0.0
	redox_syscall-0.2.16
	regex-1.7.1
	regex-syntax-0.6.28
	rustix-0.36.7
	scopeguard-1.1.0
	scratch-1.0.3
	serde-1.0.152
	shadow-rs-0.20.0
	signal-hook-0.3.14
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.0
	smallvec-1.10.0
	socket2-0.4.7
	static_assertions-1.1.0
	strsim-0.10.0
	syn-1.0.107
	termcolor-1.2.0
	thiserror-1.0.38
	thiserror-impl-1.0.38
	time-0.1.45
	time-0.3.17
	time-core-0.1.0
	time-macros-0.2.6
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tui-0.19.0
	tz-rs-0.6.14
	tzdb-0.5.3
	unicode-bidi-0.3.10
	unicode-ident-1.0.6
	unicode-normalization-0.1.22
	unicode-segmentation-1.10.0
	unicode-width-0.1.10
	unicode-xid-0.2.4
	url-2.3.1
	vcpkg-0.2.15
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
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winapi_forked_icmpapi-0.3.7
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.42.1
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