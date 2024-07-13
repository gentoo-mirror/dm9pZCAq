# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	aead@0.5.2
	aes@0.8.4
	aes-gcm@0.10.3
	ahash@0.8.11
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	atk-sys@0.10.0
	autocfg@1.3.0
	base64@0.22.1
	base64ct@1.6.0
	bincode@1.3.3
	bitflags@1.3.2
	bitflags@2.6.0
	blake2@0.9.2
	blakeout@0.3.0
	block-buffer@0.10.4
	boxfnonce@0.1.1
	bumpalo@3.16.0
	byteorder@1.5.0
	cairo-sys-rs@0.10.0
	cc@1.1.0
	cfg-if@1.0.0
	chacha20@0.9.1
	chacha20poly1305@0.10.1
	chrono@0.4.38
	cipher@0.4.4
	const-oid@0.9.6
	convert_case@0.4.0
	core-foundation-sys@0.8.6
	cpufeatures@0.2.12
	crc32fast@1.4.2
	crypto-common@0.1.6
	crypto-mac@0.8.0
	ctr@0.9.2
	curve25519-dalek@4.1.3
	curve25519-dalek-derive@0.1.1
	der@0.7.9
	deranged@0.3.11
	derive_more@0.99.18
	digest@0.9.0
	digest@0.10.7
	ed25519@2.2.3
	ed25519-dalek@2.1.1
	equivalent@1.0.1
	fiat-crypto@0.2.9
	flate2@1.0.30
	form_urlencoded@1.2.1
	gdk-pixbuf-sys@0.10.0
	gdk-sys@0.10.0
	generic-array@0.14.7
	getopts@0.2.21
	getrandom@0.2.15
	ghash@0.5.1
	gio-sys@0.10.1
	glib-sys@0.10.1
	gobject-sys@0.10.0
	gtk-sys@0.10.0
	half@1.8.3
	hashbrown@0.14.5
	heck@0.3.3
	hermit-abi@0.3.9
	hex@0.4.3
	hkdf@0.12.4
	hmac@0.12.1
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	idna@0.5.0
	indexmap@2.2.6
	inout@0.1.3
	is-docker@0.2.0
	is-wsl@0.4.0
	itoa@1.0.11
	javascriptcore-rs-sys@0.2.0
	js-sys@0.3.69
	lazy_static@1.5.0
	libc@0.2.155
	log@0.4.22
	lru@0.12.3
	memchr@2.7.4
	miniz_oxide@0.7.4
	mio@1.0.0
	num-bigint@0.4.6
	num-conv@0.1.0
	num-integer@0.1.46
	num-traits@0.2.19
	num_cpus@1.16.0
	num_threads@0.1.7
	once_cell@1.19.0
	opaque-debug@0.3.1
	open@5.2.0
	pango-sys@0.10.0
	pathdiff@0.2.1
	percent-encoding@2.3.1
	pkcs8@0.10.2
	pkg-config@0.3.30
	poly1305@0.8.0
	polyval@0.6.2
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	proc-macro2@1.0.86
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	ring@0.17.8
	rustc_version@0.4.0
	rustls@0.23.11
	rustls-pki-types@1.7.0
	rustls-webpki@0.102.5
	rustversion@1.0.17
	ryu@1.0.18
	semver@1.0.23
	serde@1.0.204
	serde_bytes@0.11.15
	serde_cbor@0.11.2
	serde_derive@1.0.204
	serde_json@1.0.120
	serde_spanned@0.6.6
	sha2@0.10.8
	signature@2.2.0
	simplelog@0.12.2
	soup-sys@0.10.0
	spin@0.9.8
	spki@0.7.3
	spmc@0.3.0
	sqlite@0.36.0
	sqlite3-src@0.6.1
	sqlite3-sys@0.17.0
	strum@0.18.0
	strum_macros@0.18.0
	subtle@2.6.1
	syn@1.0.109
	syn@2.0.70
	system-deps@1.3.2
	termcolor@1.4.1
	thiserror@1.0.61
	thiserror-impl@1.0.61
	thread-priority@1.1.0
	time@0.3.36
	time-core@0.1.2
	time-macros@0.2.18
	tinyfiledialogs@3.9.1
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	toml@0.5.11
	toml@0.8.14
	toml_datetime@0.6.6
	toml_edit@0.22.15
	typenum@1.17.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unicode-segmentation@1.11.0
	unicode-width@0.1.13
	universal-hash@0.5.1
	untrusted@0.9.0
	ureq@2.10.0
	url@2.5.2
	urlencoding@1.3.3
	uuid@1.10.0
	version-compare@0.0.10
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	web-view@0.7.3
	webkit2gtk-sys@0.12.0
	webpki-roots@0.26.3
	webview-sys@0.6.2
	widestring@1.1.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-core@0.52.0
	windows-service@0.7.0
	windows-sys@0.52.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.6.13
	winres@0.1.12
	x25519-dalek@2.0.1
	zerocopy@0.7.35
	zerocopy-derive@0.7.35
	zeroize@1.8.1
	zeroize_derive@1.4.2
"

declare -A GIT_CRATES=(
	['ecies-ed25519-ng']="https://github.com/Revertron/ecies-ed25519-ng;554ca29a1bbd55f0c7e2f75cb3c7e0e3030afc15"

	# from Cargo.lock
	['ureq']="https://github.com/algesten/ureq;1cad58f5a4f359e318858810de51666d63de70e8"
	['web-view']="https://github.com/Boscop/web-view;82d7cbce6228b1a964673cc0f22944ad808eab42"
)

inherit cargo desktop fcaps systemd tmpfiles

MY_PN="${PN^}"

DESCRIPTION="Alternative Free Identity System"
HOMEPAGE="https://github.com/Revertron/Alfis"
SRC_URI="
	https://github.com/Revertron/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="AGPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD GPL-3 MIT ISC ZLIB Unicode-DFS-2016 MPL-2.0
"

SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="X"

RESTRICT="mirror"

DEPEND="
	dev-db/sqlite:3
	X? (
		dev-libs/glib:2
		x11-libs/gtk+:3
		net-libs/webkit-gtk:4
	)
"
RDEPEND="
	${DEPEND}
	acct-user/${PN}
	acct-group/${PN}
"

FILECAPS=(
	cap_net_bind_service+ep "usr/bin/${PN}"
)

src_configure() {
	local myfeatures=($(usex X webgui ''))
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	insinto /etc
	doins "${PN}.toml"

	newtmpfiles "contrib/systemd/${PN}.tmpfiles" "${PN}.conf"
	systemd_dounit "contrib/systemd/${PN}"{,-default-config}.service

	use X && {
		domenu contrib/

		local icon='' size=''
		for icon in img/logo/*.png; do
			size="${icon##*/${PN}_icon}"
			newicon -s "${size%%.*}" "${icon}" "${PN}.png"
		done
		doicon -s scalable "img/logo/${PN}_icon.svg"
	}
}

pkg_postinst() {
	fcaps_pkg_postinst

	tmpfiles_process "${PN}.conf"
}
