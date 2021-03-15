# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Fast and Portable Telegram Crypto Library for Python"
HOMEPAGE="
	https://docs.pyrogram.org/topics/tgcrypto
	https://github.com/pyrogram/tgcrypto
"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

python_install() {
	rm -r -- "${BUILD_DIR}/lib/tests" || die 'failed to remove tests'

	distutils-r1_python_install
}
