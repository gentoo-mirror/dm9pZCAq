# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua

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
	dev-lua/lpeg[${LUA_USEDEP}]
	>=dev-lua/alt-getopt-0.7[${LUA_USEDEP}]
	>=dev-lua/luafilesystem-1.5[${LUA_USEDEP}]
"
DEPEND="${RDEPEND}"

DOCS=( docs/. README.md )

src_prepare() {
	default

	lua_copy_sources
}

moon_tool_compile() {
	local in="${1:?}"
	local out="${2:?}"
	{
		printf '%s\n\n' '#!/usr/bin/env lua'
		"${LUA}" bin/moonc -p "${in}"
		printf '\n%s\n' '-- vim: set filetype=lua:'

		printf 'Built %s\n' "${in}" 1>&2
	} > "${out}"
}

lua_src_compile() (
	set -e

	cd "${BUILD_DIR}"

	"${LUA}" bin/moonc moon/ moonscript/

	moon_tool_compile bin/moon{.moon,}
	moon_tool_compile bin/{splat.moon,moon-splat}

	find . -type f -name '*.moon' -delete
)

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() (
	cd "${BUILD_DIR}" || die
	insinto "$(lua_get_lmod_dir)"
	doins -r moon{,script}{,.lua}
)

src_install() {
	einstalldocs

	lua_foreach_impl lua_src_install

	(
		set -e

		for dir in "${WORKDIR}/${P}"-*; do :; done
		cd "${dir}"
		dobin bin/moon{,c,-splat}
	) || die
}
