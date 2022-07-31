# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{8..10})

inherit distutils-r1 toolchain-funcs

DESCRIPTION="Wren is a small, fast, class-based concurrent scripting language"
HOMEPAGE="https://wren.io/"
SRC_URI="
	https://github.com/wren-lang/${PN}/archive/${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/wren-lang/${PN}-cli/archive/${PV}.tar.gz
		-> ${PN}-cli-${PV}.tar.gz
	https://patch-diff.githubusercontent.com/raw/wren-lang/wren-cli/pull/136.patch
		-> ${P}-glibc-build.patch
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-libs/libuv"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	local f=''
	local makes=(
		projects/make/wren_shared.make
		"${WORKDIR}/wren-cli-${PV}/projects/make/wren_cli.make"
	)
	for f in "${makes[@]}"; do
		# Don't pre-strip
		sed -e '/^ALL_LDFLAGS/s/-s$//' -i "${f}" || die
	done

	cat <<-EOF >${PN}.pc
		prefix="${EPREFIX}/usr"
		libdir="\${prefix}/$(get_libdir)"
		includedir="\${prefix}/include"

		Name: ${PN}
		Description: ${DESCRIPTION}
		URL: ${HOMEPAGE}
		Version: ${PV}
		Libs: "-L\${libdir}" -l${PN}
		Cflags: "-I\${includedir}"
	EOF

	(
		cd "${WORKDIR}/wren-cli-${PV}"
		eapply "${DISTDIR}/${P}-glibc-build.patch"
	)
}

src_compile() {
	tc-export CC
	(
		cd projects/make
		emake verbose=1
	)
	(
		cd "${WORKDIR}/${PN}-cli-${PV}/projects/make"
		emake verbose=1
	)
}

python_test() {
	"${EPYTHON}" util/test.py || die
}

src_install() {
	newbin "${WORKDIR}/wren-cli-${PV}/bin/wren_cli" wren

	dolib.a lib/libwren.a
	dolib.so lib/libwren.so
	doheader src/include/wren.h
	doheader src/include/wren.hpp

	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${PN}.pc"

	einstalldocs
}
