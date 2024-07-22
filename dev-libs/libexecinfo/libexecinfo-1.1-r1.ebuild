# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="BSD licensed clone of the GNU libc backtrace facility"
HOMEPAGE="https://www.freshports.org/devel/libexecinfo"
SRC_URI="http://distcache.freebsd.org/local-distfiles/itetcu/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="elibc_musl static"

src_prepare() {
	# patches from voidlinux
	eapply -p0 "${FILESDIR}"/*.patch

	eapply_user

	sed -i "${PN}.pc" -e "/Version:/s@version@${PV}@" || die
}

src_compile() {
	append-flags '-fno-omit-frame-pointer'

	emake CC="$(tc-getCC)" AR="$(tc-getAR)" dynamic $(usev static)
}

src_install() {
	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${PN}.pc"

	doheader *.h

	dolib.so "${PN}.so.1"
	dosym "${_}" "/usr/$(get_libdir)/${PN}.so"

	use static && dolib.a *.a
}
