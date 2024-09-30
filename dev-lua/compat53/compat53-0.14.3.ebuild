# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="lua-compat-5.3"

LUA_COMPAT=(lua5-{1..4} luajit)

inherit edo flag-o-matic lua toolchain-funcs

DESCRIPTION="Compatibility module providing Lua-5.3-style APIs for Lua 5.2 and 5.1"
HOMEPAGE="
	https://luarocks.org/modules/lunarmodules/compat53
	https://github.com/lunarmodules/lua-compat-5.3
"
SRC_URI="https://github.com/lunarmodules/${MY_PN}/archive/v${PV}.tar.gz -> lua-${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"

ROCKSPEC="rockspecs/${P}-1.rockspec"

src_prepare() {
	default

	lua_copy_sources
}

rockspec_foreach_build_module() {
	local rockspec="${1:?}"
	local func="${2:?}"

	[ -f "${rockspec}" ] || die "'${rockspec}' file does not exist"

	local old_IFS="${IFS}"

	IFS=$'\n'
	local lines=($(
		edo "${LUA}" -e '
			dofile("'"${rockspec}"'");
			for dst, src in pairs(build.modules) do
				print(dst, src)
			end
		'
	))
	IFS="${old_IFS}"

	local line=''
	for line in "${lines[@]}"; do
		IFS=$'\t'
		set -- ${line}
		IFS="${old_IFS}"

		"${func}" "${1:?}" "${2:?}" || die "${func} failed: ${?}"
	done

}

rockspec_compile_c_module() {
	local dst="${1:?}"
	local src="${2:?}"

	case "${src}" in
	*.c)
		edo "${CC}" -shared -o "${dst#*.}.so" \
			${CPPFLAGS} \
			${CFLAGS} $(lua_get_CFLAGS) \
			"${src}" \
			${LDFLAGS} $(lua_get_LIBS)
		;;
	esac
}

lua_src_compile() {
	(
		cd "${BUILD_DIR}" || die

		filter-flags -ffinite-math-only

		rockspec_foreach_build_module "${ROCKSPEC}" rockspec_compile_c_module ||
			die "rockspec_foreach_build_module failed"
	)
}

src_compile() {
	lua_foreach_impl tc-env_build lua_src_compile
}

rockspec_install_module() {
	local dst="${1:?}"
	local src="${2:?}"

	case "${src}" in
	*.c)
		doexe "${dst#*.}.so"
		;;
	*.lua)
		doins "${src}"
		;;
	*)
		die "unexpected rockspec module: '${dst}' -> '${src}'"
		;;
	esac
}

lua_src_install() {
	(
		cd "${BUILD_DIR}" || die

		exeinto "$(lua_get_cmod_dir)/${PN}"
		insinto "$(lua_get_lmod_dir)/${PN}"

		rockspec_foreach_build_module "${ROCKSPEC}" rockspec_install_module ||
			die "rockspec_foreach_build_module failed"

	)
}

src_install() {
	lua_foreach_impl lua_src_install
}
