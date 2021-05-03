# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="ZSH plugin that reminds you to use existing aliases for commands you just typed"
HOMEPAGE="https://github.com/MichaelAquilina/zsh-you-should-use"
SRC_URI="
	https://github.com/MichaelAquilina/${PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"

src_install() {
	local MY_PN="${PN##zsh-}"
	local DOCS=( README.rst )

	insinto "/usr/share/zsh/site-contrib/${MY_PN}"
	doins "${MY_PN}.plugin.zsh"

	einstalldocs
}
