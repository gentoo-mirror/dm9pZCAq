# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A kernel event manager compatible with mdev.conf"
HOMEPAGE="
	https://skarnet.org/software/mdevd/
	https://github.com/skarnet/mdevd
"

if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/skarnet/${PN}.git"
	DEPEND="~dev-libs/skalibs-9999"
else
	SRC_URI="
		https://github.com/skarnet/${PN}/archive/v${PV}.tar.gz
			-> ${PF}.tar.gz
	"
	KEYWORDS="~amd64 ~arm ~x86"

	DEPEND=">=dev-libs/skalibs-2.13.0.0"
fi

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
