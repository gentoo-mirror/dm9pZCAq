# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ZSH plugin that reminds you to use existing aliases for commands you just typed"
HOMEPAGE="https://github.com/MichaelAquilina/zsh-you-should-use"
SRC_URI="
	https://github.com/MichaelAquilina/${PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"

src_install() {
	local MY_PN="${PN##zsh-}"
	local DOCS=( README.rst )

	insinto "/usr/share/zsh/site-contrib/${MY_PN}"
	doins "${MY_PN}.plugin.zsh"

	einstalldocs
}
