# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	adler32-1.2.0
	aho-corasick-0.7.18
	android_system_properties-0.1.4
	ansi_term-0.12.1
	anyhow-1.0.66
	arc-swap-1.5.0
	arrayvec-0.4.12
	arrayvec-0.7.2
	askalono-0.4.6
	atoi-1.0.0
	atty-0.2.14
	autocfg-1.1.0
	base64-0.13.0
	bit_field-0.10.1
	bitflags-1.3.2
	block-buffer-0.10.3
	bstr-0.2.17
	bstr-1.0.1
	btoi-0.4.2
	bumpalo-3.9.1
	byte-unit-4.0.14
	bytecount-0.6.3
	bytemuck-1.9.1
	byteorder-1.4.3
	bytesize-1.1.0
	castaway-0.2.2
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.4.22
	chrono-tz-0.6.1
	chrono-tz-build-0.0.2
	clap-2.34.0
	clap-4.0.15
	clap_complete-4.0.2
	clap_derive-4.0.13
	clap_lex-0.3.0
	clru-0.5.0
	cmake-0.1.48
	color_quant-1.1.0
	compact_str-0.4.0
	console-0.15.2
	core-foundation-sys-0.8.3
	cpufeatures-0.2.5
	crc-3.0.0
	crc-catalog-2.1.0
	crc32fast-1.3.2
	crossbeam-0.8.1
	crossbeam-channel-0.5.4
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.8
	crossbeam-queue-0.3.5
	crossbeam-utils-0.8.8
	crunchy-0.2.2
	crypto-common-0.1.6
	ctor-0.1.22
	dashmap-4.0.2
	dashmap-5.3.3
	deflate-1.0.0
	deunicode-0.4.3
	diff-0.1.13
	digest-0.10.5
	dirs-3.0.2
	dirs-4.0.0
	dirs-sys-0.3.7
	either-1.6.1
	enable-ansi-support-0.1.2
	encode_unicode-0.3.6
	encoding_rs-0.8.31
	encoding_rs_io-0.1.7
	env_logger-0.8.4
	errno-0.2.8
	errno-dragonfly-0.1.2
	exr-1.5.2
	fastrand-1.7.0
	filetime-0.2.16
	flate2-1.0.23
	flume-0.10.12
	fnv-1.0.7
	form_urlencoded-1.0.1
	fs_extra-1.2.0
	futures-core-0.3.21
	futures-sink-0.3.21
	generic-array-0.14.6
	getrandom-0.2.6
	gif-0.11.3
	git-actor-0.11.4
	git-actor-0.12.0
	git-attributes-0.3.3
	git-attributes-0.4.0
	git-bitmap-0.1.2
	git-chunk-0.3.1
	git-config-0.7.1
	git-credentials-0.4.0
	git-date-0.1.0
	git-date-0.2.0
	git-diff-0.18.1
	git-discover-0.4.2
	git-discover-0.5.0
	git-features-0.22.6
	git-glob-0.3.2
	git-glob-0.4.0
	git-hash-0.9.10
	git-index-0.4.3
	git-index-0.5.0
	git-lock-2.1.0
	git-mailmap-0.3.2
	git-object-0.20.3
	git-object-0.21.0
	git-odb-0.32.0
	git-pack-0.22.0
	git-path-0.4.1
	git-path-0.5.0
	git-quote-0.2.1
	git-quote-0.3.0
	git-ref-0.15.4
	git-ref-0.16.0
	git-refspec-0.1.1
	git-repository-0.23.1
	git-revision-0.4.4
	git-sec-0.3.1
	git-sec-0.4.0
	git-tempfile-2.0.1
	git-testtools-0.9.0
	git-traverse-0.16.4
	git-traverse-0.17.0
	git-url-0.7.3
	git-validate-0.5.5
	git-validate-0.6.0
	git-worktree-0.4.3
	git-worktree-0.5.0
	git2-0.15.0
	globset-0.4.8
	globwalk-0.8.1
	grep-matcher-0.1.5
	grep-searcher-0.1.8
	half-2.1.0
	hash_hasher-2.0.3
	hashbrown-0.12.1
	heck-0.4.0
	hermit-abi-0.1.19
	hex-0.4.3
	home-0.5.3
	human_format-1.0.3
	humansize-1.1.1
	humantime-2.1.0
	iana-time-zone-0.1.46
	idna-0.2.3
	ignore-0.4.18
	image-0.24.4
	indexmap-1.9.1
	insta-1.21.0
	instant-0.1.12
	io-close-0.3.7
	io-lifetimes-0.7.2
	is_ci-1.1.1
	itoa-0.4.8
	itoa-1.0.3
	jobserver-0.1.24
	jpeg-decoder-0.2.6
	js-sys-0.3.59
	jwalk-0.6.0
	lazy_static-1.4.0
	lebe-0.5.2
	libc-0.2.134
	libgit2-sys-0.14.0+1.5.0
	libz-sys-1.1.6
	linked-hash-map-0.5.6
	linux-raw-sys-0.0.46
	lock_api-0.4.7
	log-0.4.17
	lzma-sys-0.1.19
	matches-0.1.9
	memchr-2.5.0
	memmap2-0.3.1
	memmap2-0.5.3
	memoffset-0.6.5
	minimal-lexical-0.2.1
	miniz_oxide-0.5.1
	miniz_oxide-0.6.2
	nanorand-0.7.0
	nodrop-0.1.14
	nom-7.1.1
	num-format-0.4.0
	num-integer-0.1.45
	num-rational-0.4.0
	num-traits-0.2.15
	num_cpus-1.13.1
	num_threads-0.1.6
	once_cell-1.15.0
	os_str_bytes-6.0.1
	output_vt100-0.1.3
	owo-colors-3.5.0
	parking_lot-0.11.2
	parking_lot-0.12.0
	parking_lot_core-0.8.5
	parking_lot_core-0.9.3
	parse-zoneinfo-0.3.0
	paste-1.0.7
	percent-encoding-2.1.0
	pest-2.4.0
	pest_derive-2.4.0
	pest_generator-2.4.0
	pest_meta-2.4.0
	phf-0.10.1
	phf_codegen-0.10.0
	phf_generator-0.10.0
	phf_shared-0.10.0
	pin-project-1.0.10
	pin-project-internal-1.0.10
	pkg-config-0.3.25
	png-0.17.5
	ppv-lite86-0.2.16
	pretty_assertions-1.3.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.46
	prodash-20.2.0
	quick-error-2.0.1
	quote-1.0.18
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.3
	rayon-1.5.3
	rayon-core-1.9.3
	redox_syscall-0.2.13
	redox_users-0.4.3
	regex-1.6.0
	regex-automata-0.1.10
	regex-syntax-0.6.27
	remove_dir_all-0.5.3
	rmp-0.8.11
	rmp-serde-0.14.4
	rustix-0.35.7
	rustversion-1.0.6
	ryu-1.0.10
	same-file-1.0.6
	scoped_threadpool-0.1.9
	scopeguard-1.1.0
	serde-1.0.147
	serde_derive-1.0.147
	serde_json-1.0.85
	serde_yaml-0.9.13
	sha1-0.10.5
	sha1_smol-1.0.0
	signal-hook-0.3.14
	signal-hook-registry-1.4.0
	similar-2.2.0
	siphasher-0.3.10
	slug-0.1.4
	smallvec-1.9.0
	spin-0.9.3
	strsim-0.8.0
	strsim-0.10.0
	strum-0.24.1
	strum_macros-0.24.0
	syn-1.0.95
	tar-0.4.38
	tempfile-3.3.0
	tera-1.17.1
	term_size-0.3.2
	termcolor-1.1.3
	terminal_size-0.1.17
	terminal_size-0.2.1
	textwrap-0.11.0
	thiserror-1.0.35
	thiserror-impl-1.0.35
	thread_local-1.1.4
	threadpool-1.8.1
	tiff-0.7.2
	time-0.3.15
	time-humanize-0.1.3
	time-macros-0.2.4
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tokei-12.1.2
	toml-0.5.9
	typenum-1.15.0
	ucd-trie-0.1.3
	uluru-3.0.0
	uncased-0.9.7
	unic-char-property-0.9.0
	unic-char-range-0.9.0
	unic-common-0.9.0
	unic-segment-0.9.0
	unic-ucd-segment-0.9.0
	unic-ucd-version-0.9.0
	unicode-bidi-0.3.8
	unicode-bom-1.1.4
	unicode-ident-1.0.0
	unicode-normalization-0.1.19
	unicode-width-0.1.9
	unsafe-libyaml-0.2.2
	url-2.2.2
	utf8-width-0.1.6
	vcpkg-0.2.15
	vec_map-0.8.2
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.82
	wasm-bindgen-backend-0.2.82
	wasm-bindgen-macro-0.2.82
	wasm-bindgen-macro-support-0.2.82
	wasm-bindgen-shared-0.2.82
	weezl-0.1.6
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.37.0
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_aarch64_msvc-0.37.0
	windows_i686_gnu-0.36.1
	windows_i686_gnu-0.37.0
	windows_i686_msvc-0.36.1
	windows_i686_msvc-0.37.0
	windows_x86_64_gnu-0.36.1
	windows_x86_64_gnu-0.37.0
	windows_x86_64_msvc-0.36.1
	windows_x86_64_msvc-0.37.0
	xz2-0.1.7
	yaml-rust-0.4.5
	yansi-0.5.1
	zstd-0.11.2+zstd.1.5.2
	zstd-safe-5.0.2+zstd.1.5.2
	zstd-sys-2.0.1+zstd.1.5.2
	${P}
"

inherit cargo flag-o-matic

DESCRIPTION="Git repository summary on your terminal"
HOMEPAGE="
	https://crates.io/crates/onefetch
	https://github.com/o2sh/onefetch
"
SRC_URI="$(cargo_crate_uris ${CRATES})"
RESTRICT="mirror"
LICENSE="Apache-2.0 BSD CC0-1.0 MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="amd64"

src_prepare() {
	filter-flags -flto*  # building fails when compiling with LTO

	default
}

src_configure() {
	local myfeatures=( fail-on-deprecated )
	cargo_src_configure
}

src_install() {
	cargo_src_install

	doman "docs/${PN}.1"
}
