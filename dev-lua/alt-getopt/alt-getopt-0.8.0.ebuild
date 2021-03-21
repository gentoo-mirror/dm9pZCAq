# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua

MY_PN="lua-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Lua bindings to getopt_long"
HOMEPAGE="
	http://luaforge.net/projects/alt-getopt
	https://github.com/cheusov/lua-alt-getopt
"
SRC_URI="
	https://github.com/cheusov/${MY_PN}/archive/${PV}.tar.gz
		-> ${MY_P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm ppc x86 ~amd64-linux ~x86-linux"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}"
DEPEND="${RDEPEND}"

DOCS=( README )

S="${WORKDIR}/${MY_P}"
LUA_S="${MY_P}"

src_compile() { :; }

lua_src_install() {
	insinto "$(lua_get_lmod_dir)"
	doins "${PN/-/_}.lua"
}

src_install() {
	einstalldocs

	lua_foreach_impl lua_src_install
}
