# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	ahash@0.8.5
	aho-corasick@1.1.2
	anstream@0.6.4
	anstyle@1.0.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	arrayvec@0.7.4
	autocfg@1.1.0
	bindgen@0.64.0
	bitflags@1.3.2
	bytemuck@1.14.0
	cc@1.0.83
	cexpr@0.6.0
	cfg-if@1.0.0
	clang-sys@1.6.1
	clap@4.4.6
	clap_builder@4.4.6
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
	flate2@1.0.28
	gif@0.12.0
	gif-dispose@4.0.1
	glob@0.3.1
	hashbrown@0.13.2
	hermit-abi@0.3.3
	imagequant@4.2.2
	imgref@1.10.0
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.149
	libloading@0.7.4
	lodepng@3.9.1
	loop9@0.1.4
	memchr@2.6.4
	memoffset@0.9.0
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	natord@1.0.9
	nom@7.1.3
	num-traits@0.2.17
	num_cpus@1.16.0
	once_cell@1.18.0
	pbr@1.1.1
	peeking_take_while@0.1.2
	pkg-config@0.3.27
	proc-macro2@1.0.69
	quick-error@2.0.1
	quote@1.0.33
	rayon@1.8.0
	rayon-core@1.12.0
	regex@1.10.2
	regex-automata@0.4.3
	regex-syntax@0.8.2
	resize@0.8.2
	rgb@0.8.36
	rustc-hash@1.1.0
	scopeguard@1.2.0
	shlex@1.2.0
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.38
	thread_local@1.1.7
	unicode-ident@1.0.12
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	weezl@0.1.7
	wild@2.2.0
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	zerocopy@0.7.11
	zerocopy-derive@0.7.11
"
	# ${PN}@${PV}

inherit cargo

DESCRIPTION="Highest-quality GIF encoder based on pngquant"
HOMEPAGE="
	https://gif.ski/
	https://crates.io/crates/gifski
"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/ImageOptim/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="AGPL-3+"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD GPL-3+ ISC MIT Unicode-DFS-2016 WTFPL-2 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="video"

DEPEND="
	video? ( >=media-video/ffmpeg-4[dav1d(+)] )
"
RDEPEND="${DEPEND}"
BDEPEND="video? ( sys-devel/clang:* )"

QA_PRESTRIPPED="usr/bin/${PN}"

src_prepare() {
	default

	# patch for ffmpeg-sys-next is only needed for mac
	# comment it out to not depend on git source
	sed -i "${S}/Cargo.toml" \
		-e 's/^ffmpeg-sys-next\s.*/# &/' || die
}

src_configure() {
	local myfeatures=(
		binary
		gifsicle
		$(usev video)
	)
	cargo_src_configure --no-default-features
}
