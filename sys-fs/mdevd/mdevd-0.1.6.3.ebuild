# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A kernel event manager compatible with mdev.conf"
HOMEPAGE="
	https://skarnet.org/software/mdevd/
	https://github.com/skarnet/mdevd
"

SRC_URI="
	https://github.com/skarnet/${PN}/archive/v${PV}.tar.gz
		-> ${PF}.tar.gz
"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND=">=dev-libs/skalibs-2.14.0.0"

LICENSE="ISC"
SLOT="0"

RDEPEND="${DEPEND}"

src_configure() {
	econf --with-sysdeps="${EPREFIX}/usr/$(get_libdir)/skalibs"
}

src_install() {
	dobin "${PN}"{,-coldplug}

	insinto /etc
	doins "${FILESDIR}/${PN}.conf"
}
