# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PVR="${PVR/-r/_}"

DESCRIPTION="The Glasgow Haskell Compiler from voidlinux (for ghcbootstrap on musl libc)"
HOMEPAGE="https://www.haskell.org/ghc/"
SRC_URI="
	amd64? (
		https://alpha.de.repo.voidlinux.org/current/musl/${PN}-${MY_PVR}.x86_64-musl.xbps
			-> ${PF}.xbps
	)
"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="elibc_musl"

DEPEND="sys-libs/musl"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/zstd
	sys-apps/findutils
"

pkg_pretend() {
	case "${ARCH:?}" in
	amd64) :;;
	*) die 'only for amd64 ARCH';;
	esac
}

src_unpack() {
	mkdir -- "${S}" || die

	(
		set -e
		zstdcat -- "${DISTDIR}/${A}" | tar xof - -C "${S}"
	) || die 'failed to unpack'
}

src_prepare() {
	local cmd='for f; do grep -Iq lib64 "${f}"'
	cmd+=' && sed -e "s/lib64/${LIBDIR}/g" -i "${f}"; done'

	LIBDIR="$(get_libdir)" \
		find ./usr -type f -exec sh -uec "${cmd}" sh {} +

	default
}

src_install() {
	dodir /usr

	doman "./usr/share/man/man1/${PN}.1"

	(
		set -e
		mv -- "./usr/bin" "${ED}/usr/bin"
		mv -- "./usr/lib" "${ED}/usr/lib"
	) || die 'failed to move files'
}
