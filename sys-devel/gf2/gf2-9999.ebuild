# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nakst/gf.git"
else
	case "${PV}" in
		2023.09.02) COMMIT="ef796fdfbd8c83b569140c3cc61a53af7188fd81";;
		*) die "unknown commit for version: ${PV}";;
	esac
	SRC_URI="https://github.com/nakst/gf/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"

	S="${WORKDIR}/gf-${COMMIT}"
fi

DESCRIPTION="GDB frontend for Linux"
HOMEPAGE="https://github.com/nakst/gf"

LICENSE="MIT"
SLOT="0"
IUSE="cpu_flags_x86_sse2"

DEPEND="
	media-libs/freetype
	x11-libs/libX11
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

get_pkgconf() {
	local pkgconf="$(tc-getPKG_CONFIG)"
	local pkg="${1:?}"

	edo "${pkgconf}" --cflags --libs "${pkg}" || die
}

src_compile() {
	tc-export_build_env
	local cflags=(
		${BUILD_CFLAGS}
	)
	local libs=(
		-lpthread
		$(get_pkgconf x11)
		$(get_pkgconf freetype2)
		${BUILD_LDFLAGS}
	)
	local defines=(
		-DUI_FREETYPE
		$(usex cpu_flags_x86_sse2 -DUI_SSE2 '')
		${BUILD_CPPFLAGS}
	)

	edo "$(tc-getCXX)" "${defines[@]}" "${cflags[@]}" "${libs[@]}" "${PN}.cpp" -o "${PN}"
}

src_install() {
	dobin "${PN}"
}
