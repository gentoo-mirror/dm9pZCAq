# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A kernel event manager compatible with mdev.conf"
HOMEPAGE="
	https://skarnet.org/software/mdevd/
	https://github.com/skarnet/mdevd
"
EGIT_REPO_URI="https://github.com/skarnet/${PN}.git"

LICENSE="ISC"
SLOT="0"

DEPEND="~dev-libs/skalibs-9999"
RDEPEND="${DEPEND}"

src_configure() {
	econf --with-sysdeps="${EPREFIX}/usr/$(get_libdir)/skalibs"
}

src_install() {
	dobin "${PN}"{,-coldplug}
}
