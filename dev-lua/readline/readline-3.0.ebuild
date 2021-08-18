# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} luajit )

inherit flag-o-matic lua toolchain-funcs

DESCRIPTION="Interface to the readline library"
HOMEPAGE="http://pjb.com.au/comp/lua/readline.html"
SRC_URI="http://www.pjb.com.au/comp/lua/${P}.tar.gz -> lua-${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	${LUA_DEPS}
	sys-libs/readline
	>=dev-lua/luaposix-30[${LUA_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

REQUIRED_USE="${LUA_REQUIRED_USE}"

src_prepare() {
	default

	lua_copy_sources
}

cc_info() {
	tc-export_build_env
	local cflags=(
		${BUILD_CFLAGS}
		${BUILD_LDFLAGS}
		${BUILD_CPPFLAGS}

		$(lua_get_LIBS)
		"-I$(lua_get_include_dir)"
	)

	set -- "$(tc-getCC)" -fPIC -shared "${cflags[@]}" "${@}"
	einfo "${*}"
	"${@}"
}

lua_src_compile() (
	cd "${BUILD_DIR}" || die

	local pkgconf=(
		$(
			"$(tc-getPKG_CONFIG)" --libs --cflags-only-I "${PN}"
		)
	)

	filter-flags -fPIE -fpie

	cc_info "${pkgconf[@]}" "C-${PN}.c" -o "C-${PN}.so"
)

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() (
	cd "${BUILD_DIR}" || die

	exeinto "$(lua_get_cmod_dir)"
	doexe *.so

	insinto "$(lua_get_lmod_dir)"
	doins *.lua
)

src_install() {
	local DOCS=( doc/* )

	lua_foreach_impl lua_src_install

	einstalldocs
}
