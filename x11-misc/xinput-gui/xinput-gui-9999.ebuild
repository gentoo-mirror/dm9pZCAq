# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="A simple GUI for Xorg's Xinput tool"
HOMEPAGE="https://github.com/IvanFon/xinput-gui"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/IvanFon/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/IvanFon/${PN}/releases/download/${PV}/${P}.tar.gz"
	KEYWORDS="~alpha amd64 arm ~arm64 ~hppa ~ia64 ~mips ppc ppc64 sparc x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-python/pygobject
	x11-apps/xinput
	x11-libs/gtk+:3
"
