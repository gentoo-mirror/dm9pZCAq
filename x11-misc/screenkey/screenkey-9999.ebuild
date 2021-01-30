# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1 xdg

DESCRIPTION="A screencast tool to display your keys inspired by Screenflick"
HOMEPAGE="https://www.thregr.org/~wavexx/software/screenkey"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/screenkey/${PN}.git"
else
	SRC_URI="${HOMEPAGE}/releases/${P}.tar.gz"
	KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ppc ppc64 s390 sparc x86 ~x64-macos"
fi

RESTRICT="test"
LICENSE="GPL-3"
SLOT="0"

BDEPEND="
	dev-python/Babel[${PYTHON_USEDEP}]
"
RDEPEND="
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject[cairo,${PYTHON_USEDEP}]
"

src_prepare() {
	xdg_environment_reset

	sed -e "/share\/doc/s/${PN}/${P}/" -i setup.py \
		|| die 'sed failed'

	default
}
