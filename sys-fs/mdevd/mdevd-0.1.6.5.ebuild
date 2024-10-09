# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A kernel event manager compatible with mdev.conf"
HOMEPAGE="
	https://skarnet.org/software/mdevd/
	https://github.com/skarnet/mdevd
"
SRC_URI="https://github.com/skarnet/${PN}/archive/v${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND=">=dev-libs/skalibs-2.14.0.0" # in `INSTALL` it is 2.14.2.0, but it works event with 2.14.0.0
DEPEND="${RDEPEND}"

src_configure() {
	econf --with-sysdeps="${EPREFIX}/usr/$(get_libdir)/skalibs"
}

src_install() {
	dobin "${PN}"{,-coldplug}

	insinto /etc
	doins "${FILESDIR}/${PN}.conf"
}
