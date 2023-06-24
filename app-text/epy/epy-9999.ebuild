# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 optfeature

DESCRIPTION="CLI Ebook Reader"
HOMEPAGE="https://github.com/wustho/epy"
if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wustho/epy.git"
else
	PYPI_PN="${PN}-reader"
	inherit pypi

	KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~m68k ~mips ppc ~ppc64 ~riscv ~s390 sparc x86"
fi

LICENSE="GPL-3"
SLOT="0"

pkg_postinst() {
	optfeature "mobi support" dev-python/mobi

	optfeature_header "Text-to-Speech support"
	optfeature "one of needed programs for TTS" media-sound/sox
	optfeature "one of needed programs for TTS (can be found in overlays)" \
		app-accessibility/svox
}
