# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Another API-less Instagram pictures and videos downloader"
HOMEPAGE="
	https://instalooter.readthedocs.io
	https://pypi.org/project/instalooter
	https://github.com/althonos/InstaLooter
"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/fake-useragent[${PYTHON_USEDEP}]
	dev-python/fs[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/tenacity[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i setup.cfg -e 's/~=/>=/' || die 'sed failed'

	default
}
