# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua-single

DESCRIPTION="A programmer friendly language that compiles into Lua"
HOMEPAGE="https://github.com/leafo/moonscript"
SRC_URI="https://github.com/leafo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="+doc"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	$(lua_gen_cond_dep '
		dev-lua/lpeg[${LUA_USEDEP}]
		>=dev-lua/alt-getopt-0.7[${LUA_USEDEP}]
		>=dev-lua/luafilesystem-1.5[${LUA_USEDEP}]
	')
"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i "${S}/Makefile" \
		-e 's/LUA_C\?PATH=[^ ]\+//g' \
		-e 's;"#![^"]\+";"'"${LUA}"'";g' \
	|| die

	sed -i "${S}/bin/moonc" \
		-e "1d;2i#!${LUA}"

	default
}

rm_moon() {
	local f=''
	for f in "./${1:?}"/*; do
		if [ -d "${f}" ]; then
			rm_moon "${f}"
		else
			case "${f}" in
			*.moon) rm -v -- "${f}";;
			esac
		fi
	done
}

src_compile() {
	emake LUA_PATH_MAKE='' LUA_CPATH_MAKE='' compile

	rm_moon "./${PN}"
}

src_install() {
	local DOCS=( docs/. README.md )

	einstalldocs

	dobin bin/moon{,c}
	newbin bin/splat.moon moon-splat

	insinto "$(lua_get_lmod_dir)"
	doins -r moon{,script}{,.lua}
}
