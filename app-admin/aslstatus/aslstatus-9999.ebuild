# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit savedconfig

DESCRIPTION="async suckless status monitor"
HOMEPAGE="https://notabug.org/dm9pZCAq/aslstatus"
if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://notabug.org/dm9pZCAq/${PN}.git"
	VERSION=git
else
	SRC_URI="
		https://notabug.org/dm9pZCAq/${PN}/archive/${PV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"

	S="${WORKDIR}/${PN}"
	VERSION="${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+X +xkb +alsa pulseaudio"
REQUIRED_USE="xkb? ( X )"

DEPEND="
	X? ( x11-libs/libxcb[xkb?] )
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-libs/libpulse )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	restore_config {components_,}config.h
}

src_compile() {
	local audio=''
	if use pulseaudio; then
		audio=PULSE
	elif use alsa; then
		audio=ALSA
	fi

	emake VERSION="${VERSION}" \
		AUDIO="${audio}" \
		X="$(usex X 1 0)" \
		XKB="$(usex xkb 1 0)"
}

src_install() {
	local DOCS=( *.md )

	dobin "${PN}"
	doman "$([ "${PV}" = 9999 ] && printf %s 'man/')${PN}.1"

	save_config {components_,}config.h

	einstalldocs
}
