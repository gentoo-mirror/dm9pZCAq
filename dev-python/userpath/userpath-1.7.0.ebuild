# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Cross-platform tool for adding locations to the user PATH"
HOMEPAGE="
	https://pypi.org/project/userpath/
	https://github.com/ofek/userpath
"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="test"
