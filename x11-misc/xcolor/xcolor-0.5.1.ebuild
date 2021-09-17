# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ansi_term-0.11.0
	anyhow-1.0.43
	atty-0.2.14
	autocfg-1.0.1
	bitflags-1.2.1
	cc-1.0.70
	cfg-if-1.0.0
	clap-2.33.3
	hermit-abi-0.1.19
	lazy_static-1.4.0
	libc-0.2.101
	log-0.4.14
	memchr-2.4.1
	memoffset-0.6.4
	minimal-lexical-0.1.3
	nix-0.22.1
	nom-7.0.0
	pkg-config-0.3.19
	strsim-0.8.0
	textwrap-0.11.0
	unicode-width-0.1.8
	vec_map-0.8.2
	version_check-0.9.3
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	x11-2.18.2
	xcb-0.9.0
	${P}
"

inherit cargo desktop

DESCRIPTION="Lightweight color picker for X11"
HOMEPAGE="
	https://soft.github.io/xcolor/
	https://crates.io/crates/xcolor
	https://github.com/Soft/xcolor
"
SRC_URI="$(cargo_crate_uris)"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="X"

DEPEND="
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libxcb
"
RDEPEND="${DEPEND}"

src_install() {
	cargo_src_install

	doman man/*

	use X && {
		local icon='' size=''
		for icon in ./extra/icons/*.png; do
			size="${icon##*/${PN}-}"
			newicon -s "${size%%.*}" "${icon}" "${PN}.png"
		done
		doicon -s scalable "extra/icons/${PN}.svg"

		domenu "extra/${PN}.desktop"
	}
}
