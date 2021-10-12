# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	aead-0.3.2
	aead-0.4.1
	aes-0.6.0
	aes-gcm-0.8.0
	aes-soft-0.6.4
	aesni-0.10.0
	ahash-0.7.4
	atk-sys-0.10.0
	autocfg-1.0.1
	base64-0.13.0
	bincode-1.3.3
	bitflags-1.2.1
	blake2-0.9.1
	blakeout-0.3.0
	block-buffer-0.9.0
	boxfnonce-0.1.1
	bumpalo-3.7.0
	byteorder-1.4.3
	cairo-sys-rs-0.10.0
	cc-1.0.67
	cfg-if-1.0.0
	chacha20-0.8.0
	chacha20poly1305-0.9.0
	chrono-0.4.19
	chunked_transfer-1.4.0
	cipher-0.2.5
	cipher-0.3.0
	convert_case-0.4.0
	cpufeatures-0.1.4
	cpufeatures-0.2.1
	cpuid-bool-0.2.0
	crypto-mac-0.8.0
	crypto-mac-0.10.0
	ctr-0.6.0
	curve25519-dalek-3.1.0
	derive_more-0.99.16
	digest-0.9.0
	ecies-ed25519-0.5.1
	ed25519-1.0.3
	ed25519-dalek-1.0.1
	form_urlencoded-1.0.1
	gdk-pixbuf-sys-0.10.0
	gdk-sys-0.10.0
	generic-array-0.14.4
	getopts-0.2.21
	getrandom-0.1.16
	getrandom-0.2.2
	ghash-0.3.1
	gio-sys-0.10.1
	glib-sys-0.10.1
	gobject-sys-0.10.0
	gtk-sys-0.10.0
	half-1.7.1
	hashbrown-0.11.2
	heck-0.3.2
	hermit-abi-0.1.18
	hex-0.4.3
	hkdf-0.10.0
	hmac-0.10.1
	idna-0.2.3
	itoa-0.4.7
	javascriptcore-rs-sys-0.2.0
	js-sys-0.3.53
	lazy_static-1.4.0
	libc-0.2.101
	log-0.4.14
	lru-0.6.6
	matches-0.1.9
	mio-0.7.13
	miow-0.3.7
	ntapi-0.3.6
	num-bigint-0.4.2
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	once_cell-1.8.0
	opaque-debug-0.3.0
	open-2.0.1
	pango-sys-0.10.0
	pathdiff-0.2.0
	percent-encoding-2.1.0
	pest-2.1.3
	pkg-config-0.3.19
	poly1305-0.7.0
	polyval-0.4.5
	ppv-lite86-0.2.10
	proc-macro2-1.0.26
	quote-1.0.9
	rand-0.7.3
	rand-0.8.4
	rand_chacha-0.2.2
	rand_chacha-0.3.0
	rand_core-0.5.1
	rand_core-0.6.2
	rand_hc-0.2.0
	rand_hc-0.3.0
	ring-0.16.20
	rustc_version-0.3.3
	rustls-0.19.1
	ryu-1.0.5
	sct-0.6.1
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.130
	serde_bytes-0.11.5
	serde_cbor-0.11.2
	serde_derive-1.0.130
	serde_json-1.0.68
	sha2-0.9.8
	signature-1.3.1
	simplelog-0.10.2
	soup-sys-0.10.0
	spin-0.5.2
	sqlite-0.26.0
	sqlite3-src-0.3.0
	sqlite3-sys-0.13.0
	strum-0.18.0
	strum_macros-0.18.0
	subtle-2.4.0
	syn-1.0.68
	synstructure-0.12.4
	system-deps-1.3.2
	termcolor-1.1.2
	thiserror-1.0.24
	thiserror-impl-1.0.24
	thread-priority-0.2.4
	time-0.1.43
	tinyfiledialogs-3.8.3
	tinyvec-1.3.1
	tinyvec_macros-0.1.0
	toml-0.5.8
	typenum-1.13.0
	ucd-trie-0.1.3
	unicode-bidi-0.3.6
	unicode-normalization-0.1.19
	unicode-segmentation-1.7.1
	unicode-width-0.1.8
	unicode-xid-0.2.1
	universal-hash-0.4.0
	untrusted-0.7.1
	ureq-2.2.0
	url-2.2.2
	urlencoding-1.1.1
	uuid-0.8.2
	version-compare-0.0.10
	version_check-0.9.3
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.76
	wasm-bindgen-backend-0.2.76
	wasm-bindgen-macro-0.2.76
	wasm-bindgen-macro-support-0.2.76
	wasm-bindgen-shared-0.2.76
	web-sys-0.3.53
	web-view-0.7.3
	webkit2gtk-sys-0.12.0
	webpki-0.21.4
	webpki-roots-0.21.1
	webview-sys-0.6.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winres-0.1.12
	x25519-dalek-1.1.1
	zeroize-1.3.0
	zeroize_derive-1.0.1
"

inherit cargo desktop fcaps systemd tmpfiles

DESCRIPTION="Alternative Free Identity System"
HOMEPAGE="https://github.com/Revertron/Alfis"
SRC_URI="
	https://github.com/Revertron/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="Apache-2.0 BSD GPL-3 MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
RESTRICT="mirror"
IUSE="X"

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

S="${WORKDIR}/Alfis-${PV}"

FILECAPS=(
	cap_net_bind_service+ep "usr/bin/${PN}"
)

src_configure() {
	local myfeatures=( $(usex X webgui '') )
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	newtmpfiles "contrib/systemd/${PN}.tmpfiles" "${PN}.conf"
	systemd_dounit "contrib/systemd/${PN}"{,-default-config}.service

	use X && {
		make_desktop_entry contrib/*.desktop

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
