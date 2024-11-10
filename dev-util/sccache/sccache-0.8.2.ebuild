# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aes@0.8.4
	aho-corasick@1.1.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.11
	anstyle@1.0.2
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@3.0.2
	anyhow@1.0.86
	ar@0.9.0
	arc-swap@1.6.0
	arrayref@0.3.7
	arrayvec@0.7.4
	ascii@1.1.0
	assert_cmd@2.0.13
	async-trait@0.1.80
	atomic-waker@1.1.2
	autocfg@1.1.0
	backon@0.4.4
	backtrace@0.3.69
	base64@0.13.1
	base64@0.21.7
	base64@0.22.1
	base64ct@1.6.0
	bb8@0.8.1
	bincode@1.3.3
	bitflags@1.3.2
	bitflags@2.4.1
	blake3@1.5.0
	block-buffer@0.10.4
	block-padding@0.3.3
	bstr@1.9.0
	buf_redux@0.8.4
	bumpalo@3.14.0
	byteorder@1.5.0
	bytes@1.6.0
	cbc@0.1.2
	cc@1.0.83
	cfg-if@0.1.10
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	chrono@0.4.38
	chunked_transfer@1.5.0
	cipher@0.4.4
	clap@4.4.18
	clap_builder@4.4.18
	clap_derive@4.4.7
	clap_lex@0.6.0
	colorchoice@1.0.0
	combine@4.6.6
	const-oid@0.9.6
	const-random@0.1.17
	const-random-macro@0.1.16
	constant_time_eq@0.3.0
	core-foundation@0.9.4
	core-foundation-sys@0.8.6
	core_affinity@0.8.1
	cpufeatures@0.2.12
	crc16@0.4.0
	crc32c@0.6.8
	crc32fast@1.3.2
	crossbeam-utils@0.8.18
	crunchy@0.2.2
	crypto-common@0.1.6
	daemonize@0.5.0
	der@0.7.8
	deranged@0.3.11
	derive_more@0.99.17
	difflib@0.4.0
	digest@0.10.7
	directories@5.0.1
	dirs-sys@0.4.1
	displaydoc@0.1.7
	dlv-list@0.5.2
	doc-comment@0.3.3
	either@1.9.0
	encoding_rs@0.8.34
	env_logger@0.10.2
	equivalent@1.0.1
	errno@0.3.8
	error-chain@0.12.4
	fastrand@2.0.1
	filetime@0.2.23
	flagset@0.4.4
	flate2@1.0.28
	float-cmp@0.9.0
	flume@0.10.14
	fnv@1.0.7
	foreign-types@0.3.2
	foreign-types-shared@0.1.1
	form_urlencoded@1.2.1
	fs-err@2.11.0
	futures@0.3.30
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	generic-array@0.14.7
	getrandom@0.2.11
	gimli@0.28.1
	gzp@0.11.3
	h2@0.3.26
	h2@0.4.5
	hashbrown@0.14.3
	heck@0.4.1
	hermit-abi@0.3.3
	hex@0.4.3
	hmac@0.12.1
	home@0.5.9
	hostname@0.3.1
	http@0.2.11
	http@1.1.0
	http-body@0.4.6
	http-body@1.0.0
	http-body-util@0.1.1
	httparse@1.8.0
	httpdate@1.0.3
	humantime@2.1.0
	hyper@0.14.28
	hyper@1.1.0
	hyper-rustls@0.27.2
	hyper-tls@0.5.0
	hyper-tls@0.6.0
	hyper-util@0.1.3
	iana-time-zone@0.1.59
	iana-time-zone-haiku@0.1.2
	idna@0.5.0
	indexmap@2.2.5
	inout@0.1.3
	ipnet@2.9.0
	is-terminal@0.4.12
	itertools@0.12.0
	itoa@1.0.10
	jobserver@0.1.32
	js-sys@0.3.66
	jsonwebtoken@9.2.0
	lazy_static@1.4.0
	libc@0.2.155
	libm@0.2.8
	libmount@0.1.15
	libredox@0.0.1
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.12
	lock_api@0.4.11
	log@0.4.22
	match_cfg@0.1.0
	md-5@0.10.6
	memchr@2.7.1
	memmap2@0.9.4
	mime@0.3.17
	mime_guess@2.0.4
	miniz_oxide@0.7.1
	mio@0.8.11
	multipart@0.18.0
	nanorand@0.7.0
	native-tls@0.2.11
	nix@0.14.1
	nix@0.28.0
	normalize-line-endings@0.3.0
	num-bigint@0.4.4
	num-bigint-dig@0.8.4
	num-conv@0.1.0
	num-integer@0.1.45
	num-iter@0.1.43
	num-traits@0.2.17
	num_cpus@1.16.0
	num_threads@0.1.6
	number_prefix@0.4.0
	object@0.32.2
	once_cell@1.19.0
	opendal@0.48.0
	openssl@0.10.64
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.2.1+3.2.0
	openssl-sys@0.9.101
	option-ext@0.2.0
	ordered-multimap@0.7.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	pbkdf2@0.12.2
	pem@3.0.3
	pem-rfc7468@0.7.0
	percent-encoding@2.3.1
	pin-project@1.1.3
	pin-project-internal@1.1.3
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkcs1@0.7.5
	pkcs5@0.7.1
	pkcs8@0.10.2
	pkg-config@0.3.28
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	predicates@3.1.0
	predicates-core@1.0.6
	predicates-tree@1.0.9
	proc-macro2@1.0.75
	quick-error@1.2.3
	quick-xml@0.35.0
	quick-xml@0.36.1
	quinn@0.11.2
	quinn-proto@0.11.8
	quinn-udp@0.5.2
	quote@1.0.35
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redis@0.25.4
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex@1.10.3
	regex-automata@0.4.5
	regex-syntax@0.8.2
	reqsign@0.16.0
	reqwest@0.11.23
	reqwest@0.12.5
	retry@2.0.0
	ring@0.17.7
	rouille@3.6.2
	rsa@0.9.6
	rust-ini@0.21.0
	rustc-demangle@0.1.23
	rustc-hash@1.1.0
	rustc-hash@2.0.0
	rustc_version@0.4.0
	rustix@0.38.34
	rustls@0.22.4
	rustls@0.23.10
	rustls-native-certs@0.7.0
	rustls-pemfile@2.1.2
	rustls-pki-types@1.7.0
	rustls-webpki@0.102.4
	ruzstd@0.5.0
	ryu@1.0.16
	safemem@0.3.3
	salsa20@0.10.2
	same-file@1.0.6
	scc@2.1.0
	schannel@0.1.23
	scopeguard@1.2.0
	scrypt@0.11.0
	sdd@0.2.0
	security-framework@2.9.2
	security-framework-sys@2.9.1
	semver@1.0.23
	serde@1.0.201
	serde_derive@1.0.201
	serde_json@1.0.114
	serde_repr@0.1.18
	serde_spanned@0.6.5
	serde_urlencoded@0.7.1
	serial_test@3.1.0
	serial_test_derive@3.1.0
	sha1@0.10.6
	sha1_smol@1.0.0
	sha2@0.10.8
	signal-hook-registry@1.4.1
	signature@2.2.0
	simple_asn1@0.6.2
	slab@0.4.9
	smallvec@1.11.2
	socket2@0.5.5
	spin@0.5.2
	spin@0.9.8
	spki@0.7.3
	static_assertions@1.1.0
	stringmatch@0.3.3
	strip-ansi-escapes@0.2.0
	strsim@0.10.0
	subtle@2.5.0
	syn@1.0.109
	syn@2.0.48
	sync_wrapper@1.0.1
	syslog@6.1.0
	system-configuration@0.5.1
	system-configuration-sys@0.5.0
	tar@0.4.40
	temp-env@0.3.6
	tempfile@3.10.1
	termcolor@1.4.0
	terminal_size@0.3.0
	termtree@0.4.1
	test-case@3.3.1
	test-case-core@3.3.1
	test-case-macros@3.3.1
	thirtyfour@0.27.3
	thirtyfour_sync@0.27.1
	thiserror@1.0.56
	thiserror-impl@1.0.56
	threadpool@1.8.1
	time@0.3.36
	time-core@0.1.2
	time-macros@0.2.18
	tiny-keccak@2.0.2
	tiny_http@0.12.0
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio@1.37.0
	tokio-macros@2.2.0
	tokio-native-tls@0.3.1
	tokio-retry@0.3.0
	tokio-rustls@0.25.0
	tokio-rustls@0.26.0
	tokio-serde@0.8.0
	tokio-util@0.7.10
	toml@0.8.10
	toml_datetime@0.6.5
	toml_edit@0.22.6
	tower@0.4.13
	tower-layer@0.3.2
	tower-service@0.3.2
	tracing@0.1.40
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	trim-in-place@0.1.7
	try-lock@0.2.5
	twoway@0.1.8
	twox-hash@1.6.3
	typenum@1.17.0
	unicase@2.7.0
	unicode-bidi@0.3.14
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	untrusted@0.9.0
	url@2.5.0
	urlparse@0.7.3
	utf8parse@0.2.1
	uuid@1.9.0
	vcpkg@0.2.15
	version-compare@0.1.1
	version_check@0.9.4
	void@1.0.2
	vte@0.11.1
	vte_generate_state_changes@0.1.1
	wait-timeout@0.2.0
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.89
	wasm-bindgen-backend@0.2.89
	wasm-bindgen-futures@0.4.39
	wasm-bindgen-macro@0.2.89
	wasm-bindgen-macro-support@0.2.89
	wasm-bindgen-shared@0.2.89
	wasm-streams@0.4.0
	web-sys@0.3.66
	webpki-roots@0.26.2
	which@6.0.3
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	winnow@0.6.1
	winreg@0.50.0
	winreg@0.52.0
	winsafe@0.0.19
	xattr@1.2.0
	zeroize@1.7.0
	zip@0.6.6
	zstd@0.13.1
	zstd-safe@7.1.0
	zstd-sys@2.0.10+zstd.1.5.6
	${PN}@${PV}
"

inherit cargo optfeature systemd

DESCRIPTION="ccache/distcc like tool with support for rust and cloud storage"
HOMEPAGE="
	https://crates.io/crates/sccache
	https://github.com/mozilla/sccache
"

SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 ZLIB
"

SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"
IUSE="azure dist-client dist-server gcs gha memcached oss redis s3 webdav"

BDEPEND="
	virtual/pkgconfig
"
DEPEND="
	app-arch/zstd
	sys-libs/zlib:=
	dist-server? ( dev-libs/openssl:= )
	gcs? ( dev-libs/openssl:= )
"
RDEPEND="
	${DEPEND}
	dist-server? ( sys-apps/bubblewrap )
"

QA_FLAGS_IGNORED="usr/bin/sccache*"

src_configure() {
	export ZSTD_SYS_USE_PKG_CONFIG=1
	myfeatures=(
		native-zlib
		$(usev azure)
		$(usev dist-client)
		$(usev dist-server)
		$(usev gcs)
		$(usev gha)
		$(usev memcached)
		$(usev oss)
		$(usev redis)
		$(usev s3)
		$(usev webdav)
	)

	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	keepdir /etc/sccache

	einstalldocs
	dodoc -r docs/.

	if use dist-server; then
		newinitd "${FILESDIR}"/server.initd sccache-server
		newconfd "${FILESDIR}"/server.confd sccache-server

		newinitd "${FILESDIR}"/scheduler.initd sccache-scheduler
		newconfd "${FILESDIR}"/scheduler.confd sccache-scheduler

		systemd_dounit "${FILESDIR}"/sccache-server.service
		systemd_dounit "${FILESDIR}"/sccache-scheduler.service

	fi
}

pkg_postinst() {
	use memcached && optfeature "memcached backend support" net-misc/memcached
	use redis && optfeature "redis backend support" dev-db/redis
}
