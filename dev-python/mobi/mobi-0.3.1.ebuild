# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Library for unpacking unencrypted mobi files"
HOMEPAGE="
	https://pypi.org/project/mobi/
	https://github.com/iscc/mobi
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="dev-python/loguru"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	rm -- mobi/mobiml2xhtml.py || die  # until python2 syntax will be fixed
}
