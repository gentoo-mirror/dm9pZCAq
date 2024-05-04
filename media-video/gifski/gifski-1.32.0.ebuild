# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	arrayvec@0.7.4
	autocfg@1.2.0
	bindgen@0.64.0
	bitflags@1.3.2
	bytemuck@1.15.0
	cc@1.0.94
	cexpr@0.6.0
	cfg-if@1.0.0
	clang-sys@1.7.0
	clap@4.5.4
	clap_builder@4.5.2
	clap_lex@0.7.0
	colorchoice@1.0.0
	crc32fast@1.4.0
	crossbeam-channel@0.5.12
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	dunce@1.0.4
	either@1.11.0
	fallible_collections@0.4.9
	ffmpeg-next@6.1.1
	ffmpeg-sys-next@6.1.0
	flate2@1.0.28
	gif@0.13.1
	gif-dispose@5.0.0
	glob@0.3.1
	hashbrown@0.13.2
	hermit-abi@0.3.9
	imagequant@4.3.0
	imgref@1.10.1
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.153
	libloading@0.8.3
	lodepng@3.10.1
	loop9@0.1.5
	memchr@2.7.2
	minimal-lexical@0.2.1
	miniz_oxide@0.7.2
	natord@1.0.9
	nom@7.1.3
	num-traits@0.2.18
	num_cpus@1.16.0
	once_cell@1.19.0
	ordered-channel@1.1.0
	pbr@1.1.1
	peeking_take_while@0.1.2
	pkg-config@0.3.30
	proc-macro2@1.0.79
	quick-error@2.0.1
	quote@1.0.36
	rayon@1.10.0
	rayon-core@1.12.1
	regex@1.10.4
	regex-automata@0.4.6
	regex-syntax@0.8.3
	resize@0.8.4
	rgb@0.8.37
	rustc-hash@1.1.0
	shlex@1.3.0
	strsim@0.11.1
	syn@1.0.109
	syn@2.0.58
	thread_local@1.1.8
	unicode-ident@1.0.12
	utf8parse@0.2.1
	vcpkg@0.2.15
	version_check@0.9.4
	weezl@0.1.8
	wild@2.2.1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.52.0
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.52.5
	y4m@0.8.0
	yuv@0.1.5
	zerocopy@0.7.32
	zerocopy-derive@0.7.32
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
IUSE="video"

DEPEND="
	video? ( >=media-video/ffmpeg-4[dav1d(+)] )
"
RDEPEND="${DEPEND}"
BDEPEND="video? ( sys-devel/clang:* )"

QA_PRESTRIPPED="usr/bin/${PN}"

# src_prepare() {
# 	default

# 	# patch for ffmpeg-sys-next is only needed for mac
# 	# comment it out to not depend on git source
# 	sed -i "${S}/Cargo.toml" \
# 		-e 's/^ffmpeg-sys-next\s.*/# &/' || die
# }

src_configure() {
	local myfeatures=(
		binary
		gifsicle
		$(usev video)
	)
	cargo_src_configure --no-default-features
}
