# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{9..11})
DISTUTILS_USE_SETUPTOOLS=bdepend

inherit distutils-r1 xdg

DESCRIPTION="A screencast tool to display your keys inspired by Screenflick"
HOMEPAGE="https://www.thregr.org/~wavexx/software/screenkey"

if [[ ${PV} == *_p20230109 ]] ; then
	COMMIT=7bdba66574244061c6e1934c4f204d02d570f182
	SRC_URI="https://gitlab.com/${PN}/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2
		-> ${P}.tar.bz2"
	S="${WORKDIR}"/${PN}-${COMMIT}
else
	SRC_URI="https://gitlab.com/${PN}/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
		-> ${P}.tar.bz2"
	S="${WORKDIR}"/${PN}-v${PV}
fi

KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ppc ppc64 s390 sparc x86 ~x64-macos"

RESTRICT="test"
LICENSE="GPL-3"
SLOT="0"
IUSE="appindicator dbus"

BDEPEND="
	dev-python/Babel[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"
RDEPEND="
	dbus? ( dev-python/dbus-python[${PYTHON_USEDEP}] )
	appindicator? ( dev-libs/libappindicator:3[introspection] )
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject[cairo,${PYTHON_USEDEP}]
	x11-libs/gtk+:3[X,introspection]
	x11-misc/slop
"

src_prepare() {
	xdg_environment_reset

	sed -e "/share\/doc/s/${PN}/${P}/" -i setup.py \
		|| die 'sed failed'

	use dbus || eapply "${FILESDIR}/no-dbus-${PV}.patch"

	default
}
