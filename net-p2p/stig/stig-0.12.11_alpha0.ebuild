# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi optfeature

DESCRIPTION="TUI and CLI for the BitTorrent client Transmission"
HOMEPAGE="
	https://pypi.org/project/stig/
	https://github.com/rndusr/stig
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/urwid-2.6.12[${PYTHON_USEDEP}]
	~dev-python/urwidtrees-1.0.3[${PYTHON_USEDEP}]
	=dev-python/aiohttp-3*[${PYTHON_USEDEP}]
	dev-python/async-timeout[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/blinker[${PYTHON_USEDEP}]
	dev-python/natsort[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

pkg_postinst() {
	optfeature "Tunnel the connection to the Transmission daemon through a SOCKS5, SOCKS4 or HTTP proxy" \
		dev-python/aiohttp-socks
	optfeature "Strip arguments from process title when running in tmux session" dev-python/setproctitle
}
