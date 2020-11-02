# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
inherit distutils-r1

DESCRIPTION="Pure Python 3 MTProto API Telegram client library, for bots too!"
HOMEPAGE="https://telethon.dev/ https://github.com/LonamiWebs/Telethon/"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc ~ppc64 sparc x86"

DEPEND="
	dev-python/pyaes
	dev-python/rsa
"
RDEPEND="${DEPEND}"

src_configure() {
	rm -rf ./tests || die

	default
}
