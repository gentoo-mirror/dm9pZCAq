# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Compiler Backend"
HOMEPAGE="https://c9x.me/compile/"
EGIT_REPO_URI="git://c9x.me/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake V=
}

src_install() {
	local DOCS=( doc/* )

	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	einstalldocs
}
