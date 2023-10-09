# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	ahash@0.8.3
	aho-corasick@1.1.1
	anstream@0.5.0
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@2.1.0
	anstyle@1.0.3
	arrayvec@0.7.4
	autocfg@1.1.0
	bindgen@0.64.0
	bitflags@1.3.2
	bytemuck@1.14.0
	cc@1.0.83
	cexpr@0.6.0
	cfg-if@1.0.0
	clang-sys@1.6.1
	clap@4.4.4
	clap_builder@4.4.4
	clap_lex@0.5.1
	colorchoice@1.0.0
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.8.16
	dunce@1.0.4
	either@1.9.0
	fallible_collections@0.4.9
	ffmpeg-next@6.0.0
	ffmpeg-sys-next@6.0.1
	flate2@1.0.27
	gif-dispose@4.0.1
	gif@0.12.0
	gifsicle@1.93.0
	glob@0.3.1
	hashbrown@0.13.2
	hermit-abi@0.3.3
	imagequant@4.2.1
	imgref@1.9.4
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.148
	libloading@0.7.4
	lodepng@3.8.2
	loop9@0.1.4
	memchr@2.6.3
	memoffset@0.9.0
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	natord@1.0.9
	nom@7.1.3
	num-traits@0.2.16
	num_cpus@1.16.0
	once_cell@1.18.0
	pbr@1.1.1
	peeking_take_while@0.1.2
	pkg-config@0.3.27
	proc-macro2@1.0.67
	quick-error@2.0.1
	quote@1.0.33
	rayon-core@1.12.0
	rayon@1.8.0
	regex-automata@0.3.8
	regex-syntax@0.7.5
	regex@1.9.5
	resize@0.8.2
	rgb@0.8.36
	rustc-hash@1.1.0
	scopeguard@1.2.0
	shlex@1.2.0
	strsim@0.10.0
	syn@1.0.109
	thread_local@1.1.7
	unicode-ident@1.0.12
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	weezl@0.1.7
	wild@2.2.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	${PN}@${PV}
"

inherit cargo

DESCRIPTION="Highest-quality GIF encoder based on pngquant"
HOMEPAGE="
	https://gif.ski/
	https://crates.io/crates/gifski
"
SRC_URI="${CARGO_CRATE_URIS}"

LICENSE="AGPL-3+"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD GPL-3+ ISC MIT Unicode-DFS-2016 WTFPL-2 ZLIB"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+openmp video"

DEPEND="
	openmp? ( sys-libs/libomp )
	video? ( >=media-video/ffmpeg-4[dav1d(+)] )
"
RDEPEND="${DEPEND}"
BDEPEND="video? ( sys-devel/clang:* )"

QA_PRESTRIPPED="usr/bin/${PN}"

src_configure() {
	local myfeatures=(
		binary
		gifsicle
		$(usev openmp)
		$(usev video)
	)
	cargo_src_configure --no-default-features
}
