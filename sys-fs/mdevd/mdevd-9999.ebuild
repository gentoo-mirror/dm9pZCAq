# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A kernel event manager compatible with mdev.conf"
HOMEPAGE="
	https://skarnet.org/software/mdevd/
	https://github.com/skarnet/mdevd
"

case "${PVR}" in
*9999*)
	inherit git-r3
	EGIT_REPO_URI="https://github.com/skarnet/${PN}.git"
	DEPEND="~dev-libs/skalibs-9999"
	;;
*_pre*)
	COMMIT=8797fba30db6f2587753346bee4d1f11c9d5b8ed
	SRC_URI="
		https://github.com/skarnet/${PN}/archive/${COMMIT}.tar.gz
			-> ${PF}.tar.gz
	"
	KEYWORDS="~amd64 ~arm ~x86"

	DEPEND=">=dev-libs/skalibs-2.11.0.0_pre"

	S="${WORKDIR}/${PN}-${COMMIT}"
	;;
esac

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
