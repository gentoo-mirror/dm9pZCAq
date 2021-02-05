# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..8} )

inherit distutils-r1

DESCRIPTION="TUI and CLI for the BitTorrent client Transmission"
HOMEPAGE="
	https://pypi.org/project/stig
	https://github.com/rndusr/stig
"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${PF/_pre/}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+proctitle"
DISTUTILS_USE_SETUPTOOLS=rdepend

RDEPEND="
	>=dev-python/urwid-2.0[${PYTHON_USEDEP}]
	>=dev-python/urwidtrees-1.0.3[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3[${PYTHON_USEDEP}]
	<dev-python/aiohttp-4[${PYTHON_USEDEP}]
	dev-python/async_timeout[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/blinker[${PYTHON_USEDEP}]
	dev-python/natsort[${PYTHON_USEDEP}]
	proctitle? ( dev-python/setproctitle[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PF/_pre/}"
