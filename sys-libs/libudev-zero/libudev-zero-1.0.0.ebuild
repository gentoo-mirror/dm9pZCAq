# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Daemonless replacement for libudev"
HOMEPAGE="https://github.com/illiliti/libudev-zero"
SRC_URI="
	https://github.com/illiliti/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"

IUSE="+hotplug static static-libs"

cc_info() {
	tc-export_build_env
	local cflags=(
		${BUILD_CFLAGS}
		${BUILD_LDFLAGS}
		${BUILD_CPPFLAGS}
	)

	set -- "$(tc-getCC)" "${cflags[@]}" "${@}"
	einfo "${*}"
	"${@}"
}

src_prepare() {
	default

	use static-libs || {
		sed -i Makefile \
			-e '/^\(inst\)\?all:/s/libudev.a//' \
			-e '/^install:/,/^uninstall:/{/libudev.a/d}' \
		|| die
	}
}

src_compile() {
	emake

	use hotplug \
		&& cc_info $(usex static -static '') contrib/helper.c -o "${PN}-helper"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	use hotplug && {
		dobin "${PN}-helper"

		insinto "/usr/share/doc/${P}/examples"
		sed "s;/path/to/helper;${PN}-helper;g" contrib/mdev.conf \
			| newins - mdev.conf
	}
}
