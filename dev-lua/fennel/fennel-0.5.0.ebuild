# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua optfeature

DESCRIPTION="Lua Lisp Language"
HOMEPAGE="
	https://fennel-lang.org/
	https://github.com/bakpakin/Fennel
"
SRC_URI="
	https://github.com/bakpakin/${PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
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

S="${WORKDIR}/$(
	f="${PN::1}"
	printf '%s' "${f^^}${P:1}"
)"

src_prepare() {
	default

	lua_copy_sources
}

lua_src_compile() {
	cd "${BUILD_DIR}" || die
	emake "${PN}"
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	cd "${BUILD_DIR}" || die

	insinto "$(lua_get_lmod_dir)"
	doins *.lua
}

src_install() {
	local DOCS=( [^C]*.md )  # skip CODE-OF-CONDUCT and CONTRIBUTING

	lua_foreach_impl lua_src_install

	einstalldocs

	(
		set -eo pipefail

		for dir in "${WORKDIR}/${P}"-*; do :; done
		cd "${dir}"
		sed '1,1s;^.*$;#!/usr/bin/lua;' ./fennel \
			| newbin /proc/self/fd/0 "${PN}"
	) || die
}

pkg_postinst() {
	optfeature "readline support" dev-lua/readline
}
