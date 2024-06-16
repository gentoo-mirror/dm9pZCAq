# Copyright 2017-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.19.0
	adler@1.0.2
	ahash@0.7.6
	ahash@0.8.3
	aho-corasick@0.7.20
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anyhow@1.0.71
	arrayvec@0.7.2
	asyncgit@0.23.0
	atty@0.2.14
	autocfg@1.1.0
	backtrace@0.3.67
	base64@0.13.1
	bincode@1.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bugreport@0.5.0
	bumpalo@3.12.0
	bytemuck@1.13.0
	bytesize@1.2.0
	cassowary@0.3.0
	cc@1.0.79
	cfg-if@1.0.0
	chrono@0.4.26
	clap@4.1.14
	clap_builder@4.1.14
	clap_lex@0.4.0
	codespan-reporting@0.11.1
	core-foundation-sys@0.8.3
	cpp_demangle@0.4.0
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.2
	crossbeam-epoch@0.9.13
	crossbeam-utils@0.8.14
	crossterm@0.26.1
	crossterm_winapi@0.9.0
	ctor@0.1.26
	cxx@1.0.90
	cxx-build@1.0.90
	cxxbridge-flags@1.0.90
	cxxbridge-macro@1.0.90
	debugid@0.8.0
	diff@0.1.13
	dirs@4.0.0
	dirs-next@2.0.0
	dirs-sys@0.3.7
	dirs-sys-next@0.1.2
	easy-cast@0.5.2
	either@1.8.1
	errno@0.2.8
	errno-dragonfly@0.1.2
	fancy-regex@0.7.1
	fastrand@1.8.0
	filetime@0.2.20
	filetreelist@0.5.0
	findshlibs@0.10.2
	flate2@1.0.25
	fnv@1.0.7
	form_urlencoded@1.2.0
	fsevent-sys@4.1.0
	fuzzy-matcher@0.3.7
	getrandom@0.2.8
	gh-emoji@1.0.7
	gimli@0.27.1
	git-version@0.3.5
	git-version-macro@0.3.5
	git2@0.17.2
	gitui@0.23.0
	hashbrown@0.12.3
	hermit-abi@0.1.19
	hermit-abi@0.2.6
	hermit-abi@0.3.1
	iana-time-zone@0.1.53
	iana-time-zone-haiku@0.1.1
	idna@0.4.0
	indexmap@1.9.2
	inferno@0.11.14
	inotify@0.9.6
	inotify-sys@0.1.5
	instant@0.1.12
	io-lifetimes@1.0.5
	is-terminal@0.4.3
	itertools@0.10.5
	itoa@1.0.5
	jobserver@0.1.25
	js-sys@0.3.61
	kqueue@1.0.7
	kqueue-sys@1.0.3
	lazy_static@1.4.0
	libc@0.2.139
	libgit2-sys@0.15.2+1.6.4
	libssh2-sys@0.3.0
	libz-sys@1.1.8
	link-cplusplus@1.0.8
	linux-raw-sys@0.1.4
	lock_api@0.4.9
	log@0.4.19
	memchr@2.5.0
	memmap2@0.5.8
	memoffset@0.7.1
	miniz_oxide@0.6.2
	mio@0.8.5
	nix@0.26.2
	notify@5.1.0
	notify-debouncer-mini@0.2.1
	num-format@0.4.4
	num-traits@0.2.15
	num_cpus@1.15.0
	object@0.30.3
	once_cell@1.18.0
	onig@6.4.0
	onig_sys@69.8.1
	openssl-probe@0.1.5
	openssl-src@111.25.0+1.1.1t
	openssl-sys@0.9.88
	output_vt100@0.1.3
	parking_lot@0.12.1
	parking_lot_core@0.9.7
	percent-encoding@2.3.0
	phf@0.11.1
	phf_shared@0.11.1
	pkg-config@0.3.26
	pprof@0.11.1
	pretty_assertions@1.3.0
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro-hack@0.5.20+deprecated
	proc-macro2@1.0.51
	quick-xml@0.26.0
	quote@1.0.23
	ratatui@0.21.0
	rayon-core@1.11.0
	redox_syscall@0.2.16
	redox_users@0.4.3
	regex@1.7.1
	regex-syntax@0.6.28
	rgb@0.8.35
	ron@0.8.0
	rustc-demangle@0.1.21
	rustix@0.36.8
	ryu@1.0.12
	same-file@1.0.6
	scopeguard@1.1.0
	scopetime@0.1.2
	scratch@1.0.3
	serde@1.0.156
	serde_derive@1.0.156
	serde_json@1.0.93
	shell-escape@0.1.5
	shellexpand@3.1.0
	signal-hook@0.3.14
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.0
	simplelog@0.12.1
	siphasher@0.3.10
	smallvec@1.10.0
	smawk@0.3.1
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	str_stack@0.1.0
	strsim@0.10.0
	struct-patch@0.2.3
	struct-patch-derive@0.2.3
	symbolic-common@10.2.1
	symbolic-demangle@10.2.1
	syn@1.0.107
	syntect@5.0.0
	sys-info@0.9.1
	tempfile@3.4.0
	termcolor@1.2.0
	textwrap@0.16.0
	thiserror@1.0.39
	thiserror-impl@1.0.39
	thread_local@1.1.4
	time@0.3.17
	time-core@0.1.0
	time-macros@0.2.6
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	unicode-bidi@0.3.10
	unicode-ident@1.0.6
	unicode-linebreak@0.1.4
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unicode-truncate@0.2.0
	unicode-width@0.1.10
	url@2.4.0
	uuid@1.3.0
	vcpkg@0.2.15
	version_check@0.9.4
	walkdir@2.3.2
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.84
	wasm-bindgen-backend@0.2.84
	wasm-bindgen-macro@0.2.84
	wasm-bindgen-macro-support@0.2.84
	wasm-bindgen-shared@0.2.84
	which@4.4.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.42.0
	windows-sys@0.45.0
	windows-targets@0.42.1
	windows_aarch64_gnullvm@0.42.1
	windows_aarch64_msvc@0.42.1
	windows_i686_gnu@0.42.1
	windows_i686_msvc@0.42.1
	windows_x86_64_gnu@0.42.1
	windows_x86_64_gnullvm@0.42.1
	windows_x86_64_msvc@0.42.1
	yansi@0.5.1
"

PATCHES=(
	"${FILESDIR}/registry.patch"
)

inherit cargo desktop fcaps systemd tmpfiles

DESCRIPTION="Alternative Free Identity System"
HOMEPAGE="https://github.com/Revertron/Alfis"
SRC_URI="
	https://github.com/Revertron/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/Alfis-${PV}"

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
	local myfeatures=( $(usex X webgui '') )
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	insinto /etc
	newins "${PN}.toml" "${PN}.conf"

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
