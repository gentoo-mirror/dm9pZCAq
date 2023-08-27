# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Save own keyboard layout for each window"
HOMEPAGE="https://notabug.org/dm9pZCAq/clayout"

if [ "${PV}" = 9999 ]; then

	inherit git-r3
	EGIT_REPO_URI="https://notabug.org/dm9pZCAq/${PN}.git"
else
	SRC_URI="
		https://notabug.org/dm9pZCAq/${PN}/archive/${PV}.tar.gz
			-> ${P}.tar.gz
	"

	KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"

	S="${WORKDIR}/${PN}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="x11-libs/libxcb[xkb]"
RDEPEND="${DEPEND}"

src_install() {
	dobin "${PN}"
}
