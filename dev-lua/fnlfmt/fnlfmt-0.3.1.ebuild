# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=(lua5-{1..4} luajit)

inherit lua-single

DESCRIPTION="A formatter for Fennel code"
HOMEPAGE="https://git.sr.ht/~technomancy/fnlfmt"
SRC_URI="
	https://git.sr.ht/~technomancy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm ppc x86 ~amd64-linux ~x86-linux"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/fennel"

src_compile() {
	(
		set -x
		{
			printf '%s\n\n' "#!${LUA}" &&
				fennel --require-as-include --compile cli.fnl
		} >"./${PN}" || die
	)
}

src_install() {
	dobin "./${PN}"
}
