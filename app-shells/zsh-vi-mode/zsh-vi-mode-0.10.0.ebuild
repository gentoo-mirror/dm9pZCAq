# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A better and friendly vi(vim) mode plugin for ZSH."
HOMEPAGE="https://github.com/jeffreytse/zsh-vi-mode"
SRC_URI="
	https://github.com/jeffreytse/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"

src_install() {
	insinto "/usr/share/zsh/site-contrib/${PN}"
	doins "${PN}"{,.plugin}.zsh

	einstalldocs
}
