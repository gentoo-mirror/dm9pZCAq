# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="General-purpose libraries from skarnet.org"
HOMEPAGE="https://www.skarnet.org/software/skalibs/"

if [ "${PV}" = 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/skarnet/${PN}.git"
else
	SRC_URI="
		https://github.com/skarnet/${PN}/archive/v${PV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="amd64 arm x86"
fi

LICENSE="ISC"
SLOT="0/$(ver_cut 1-2)"
IUSE="doc ipv6 static-libs"

HTML_DOCS=( doc/. )

src_prepare() {
	default

	# Avoid QA warning for LDFLAGS addition; avoid overriding -fstack-protector
	sed -i -e 's/.*-Wl,--hash-style=both$/:/' -e '/-fno-stack-protector$/d' \
		configure || die
}

src_configure() {
	econf \
		--datadir=/etc \
		--dynlibdir=/usr/$(get_libdir) \
		--libdir=/usr/$(get_libdir)/${PN} \
		--sysdepdir=/usr/$(get_libdir)/${PN} \
		--enable-clock \
		--enable-shared \
		$(use_enable static-libs static) \
		$(use_enable ipv6)
}
