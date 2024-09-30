# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="tl"

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua-single

DESCRIPTION="The compiler for Teal, a typed dialect of Lua"
HOMEPAGE="
	https://github.com/teal-language/tl
	https://github.com/teal-language
"
SRC_URI="https://github.com/${PN}-language/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"

DEPEND="
	${LUA_DEPS}
	$(lua_gen_cond_dep '
		>=dev-lua/compat53-0.11[${LUA_USEDEP}]
		dev-lua/lua-argparse[${LUA_USEDEP}]
		dev-lua/luafilesystem[${LUA_USEDEP}]
	')

"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# change shebang
	sed -i "./${MY_PN}" \
		-e '1s;^.*$;#!'"${LUA}"';'
}

src_compile() {
	emake selfbuild
}

src_install() {
	local DOCS=( docs/*.md )

	dobin "./${MY_PN}"

	insinto "$(lua_get_lmod_dir)"
	doins "./${MY_PN}.lua"

	einstalldocs
}
