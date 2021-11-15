# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua-single optfeature

DESCRIPTION="Lua Lisp Language"
HOMEPAGE="
	https://fennel-lang.org/
	https://sr.ht/~technomancy/fennel/
"
SRC_URI="
	https://git.sr.ht/~technomancy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm ppc x86 ~amd64-linux ~x86-linux"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	app-eselect/eselect-lua
"
DEPEND="${RDEPEND}"

src_install() {
	local DOCS=( [^C]*.md )  # skip CODE-OF-CONDUCT and CONTRIBUTING

	dobin "${PN}"
	doman "${PN}.1"

	insinto "$(lua_get_lmod_dir)"
	doins *.lua

	einstalldocs
}

pkg_postinst() {
	optfeature "readline support" dev-lua/readline
}
