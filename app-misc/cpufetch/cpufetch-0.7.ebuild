# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Simplistic yet fancy CPU architecture fetching tool "
HOMEPAGE="https://github.com/Dr-Noob/cpufetch"
SRC_URI="
	https://github.com/Dr-Noob/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

src_prepare() {
	sed -i Makefile \
		-e 's/\<CXX\>/CC/g' \
		-e 's/\<CXXFLAGS\>/CFLAGS/g' \
		-e 's/-Werror//g' \
		-e 's/-static//g' \
		-e '/^CC=/s/=/?=/' \
		-e '/^CXXFLAGS=/s/=/+=/' \
		|| die 'sed failed'
	default
}

src_install() {
	exeinto /usr/bin
	doexe "${PN}"
	doman "${PN}.8"
}
