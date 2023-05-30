# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Install and Run Python Applications in Isolated Environments"
HOMEPAGE="
	https://pypa.github.io/pipx/
	https://github.com/pypa/pipx/
"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/userpath-1.6.0[${PYTHON_USEDEP}]

	>=dev-python/argcomplete-1.9.4[${PYTHON_USEDEP}]

	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]

	>=dev-python/importlib-metadata-3.3.0[${PYTHON_USEDEP}]
"

RDEPEND="${DEPEND}"
