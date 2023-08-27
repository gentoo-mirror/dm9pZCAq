# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit savedconfig

DESCRIPTION="Daemon-less notifications without D-Bus"
HOMEPAGE="https://github.com/dudik/herbe"
SRC_URI="${HOMEPAGE}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"

DEPEND="
	x11-libs/libX11
	x11-libs/libXft
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i Makefile -e '/^CFLAGS/s/=/+&/' || die

	restore_config config.h
}

src_install() {
	local DOCS=( README.md )

	dobin "${PN}"

	save_config config.h

	einstalldocs
}
