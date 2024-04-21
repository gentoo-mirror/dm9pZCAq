# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nakst/gf.git"
else
	case "${PV}" in
	2023.12.06) COMMIT="82889c4de974db4508e669c8d909c33be20bf798" ;;
	*) die "unknown commit for version: ${PV}" ;;
	esac
	SRC_URI="https://github.com/nakst/gf/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"

	S="${WORKDIR}/gf-${COMMIT}"
fi

DESCRIPTION="GDB frontend for Linux"
HOMEPAGE="https://github.com/nakst/gf"

LICENSE="MIT"
SLOT="0"
IUSE="+extensions cpu_flags_x86_sse2"

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

	use extensions && ln -vs extensions_v5/extensions.cpp

	edo "$(tc-getCXX)" "${defines[@]}" "${cflags[@]}" "${libs[@]}" "${PN}.cpp" -o "${PN}"
}

src_install() {
	local DOCS=(README.md)
	use extensions && DOCS+=(
		extensions_v5/gf_profiling.c
		extensions_v5/*.txt
	)

	dobin "${PN}"

	einstalldocs
}

pkg_postinst() {
	use extensions && {
		local docs="${EROOT}/usr/share/doc/${PF}/"
		einfo "see '${docs}' for more info about extensions"
	}
}
