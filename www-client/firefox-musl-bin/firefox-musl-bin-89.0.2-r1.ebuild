# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=${PVR/r/}
MY_PN=${PN%%-musl-bin}

HARDENED_PV='1.0'
PRIVACY="https://github.com/kiss-community/repo-main/raw/master/extra/firefox-privacy"

DESCRIPTION="Firefox binary from KISS linux (for musl libc)"
HOMEPAGE="
	https://github.com/kiss-community/repo-bin
	https://github.com/kiss-community/repo-main/tree/master/extra/firefox
"
SRC_URI="
	https://github.com/kiss-community/repo-bin/releases/download/ff-${PV}/${MY_PN}@${MY_PV}.tar.xz
		-> ${PF}.tar.xz
	hardened? (
		${PRIVACY}/files/policies-${HARDENED_PV}.json
			-> ${PN}.policies-${HARDENED_PV}.json
		${PRIVACY}/files/vendor-${HARDENED_PV}.js
			-> ${PN}.vendor-${HARDENED_PV}.js
	)
"
IUSE="elibc_musl +hardened"

LICENSE="MIT MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="
	dev-libs/atk
	>=dev-libs/glib-2.26:2
	dev-libs/libffi:0/7
	>=dev-libs/nspr-4.29
	>=dev-libs/nss-3.62
	media-libs/alsa-lib
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	>=media-libs/harfbuzz-2.6.8:0=
	>=media-libs/libpng-1.6.35:0=[apng]
	sys-devel/gcc:11=
	~sys-libs/musl-1.2.2
	>=sys-libs/zlib-1.2.3
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-3.4.0:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libxcb
	>=x11-libs/pango-1.22.0
	>=x11-libs/pixman-0.19.2

	dev-libs/expat
	virtual/freedesktop-icon-theme
	media-video/ffmpeg
	>=media-libs/libjpeg-turbo-1.2.1
	>=media-libs/libvpx-1.8.2:0=[postproc]
	>=media-libs/mesa-10.2:*
	>=media-libs/dav1d-0.8.1:=
	>=media-libs/libaom-1.0.0:=
"
DEPEND="
	!www-client/firefox
	${RDEPEND}
"

src_unpack() {
	mkdir -- "${P}" && cd -- "${P}" || die 'failed to prepare unpack dir'

	default
}

src_install() {
	dosym "../lib/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"

	rm -- "./usr/lib/${MY_PN}/${PN/-musl/}" || die
	mv -- ./usr/lib "${ED}/usr/" || die

	use hardened && {
		insinto "/usr/lib/${MY_PN}/browser/defaults/preferences"
		newins "${DISTDIR}/${PN}.vendor-${HARDENED_PV}.js" vendor.js

		insinto "/usr/lib/${MY_PN}/distribution"
		newins "${DISTDIR}/${PN}.policies-${HARDENED_PV}.json" policies.json
	}
}
