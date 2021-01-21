# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

HARDENED_PV='1.0'
RELEASE='2020.9-2'

MY_PV=${PVR/r/}
MY_PN=${PN%%-musl-bin}

DESCRIPTION="Firefox binary from KISS linux (for musl libc)"
HOMEPAGE="
	https://github.com/kisslinux/repo
	https://github.com/kisslinux/repo/tree/master/extra/firefox
"
SRC_URI="
	https://github.com/kisslinux/repo/releases/download/${RELEASE}/${MY_PN}.${MY_PV}.tar.gz
		-> ${PN}.${MY_PV}.tar.gz
	hardened? (
		https://github.com/kisslinux/repo/raw/master/extra/firefox-privacy/files/policies-${HARDENED_PV}.json
			-> ${PN}.policies-${HARDENED_PV}.json
		https://github.com/kisslinux/repo/raw/master/extra/firefox-privacy/files/vendor-${HARDENED_PV}.js
			-> ${PN}.vendor-${HARDENED_PV}.js
	)
"
IUSE="elibc_musl +hardened"

LICENSE="MIT MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip"

RDEPEND="
	dev-libs/atk
	>=dev-libs/glib-2.26:2
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-3.4.0:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	>=x11-libs/pango-1.22.0
	media-video/ffmpeg
	<sys-libs/musl-1.2.2
	>sys-libs/musl-1.1
"

src_unpack() {
	mkdir -- "${P}" && cd -- "${P}" || die 'failed to prepare unpack dir'

	default
}

src_install() {
	dosym ../lib/firefox/firefox /usr/bin/firefox

	mv ./usr/lib "${ED}/usr/" || die 'failed to copy firefox files'

	use hardened && {
		insinto /usr/lib/firefox/browser/defaults/preferences
		newins "${DISTDIR}/${PN}.vendor-${HARDENED_PV}.js" vendor.js

		insinto /usr/lib/firefox/distribution
		newins "${DISTDIR}/${PN}.policies-${HARDENED_PV}.json" policies.json
	}
}
