# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="A better hexdump"
HOMEPAGE="https://github.com/kiedtl/huxdemp"
SRC_URI="
	${HOMEPAGE}/archive/${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+doc"

DEPEND="!dev-util/hxd"
BDEPEND="doc? ( app-text/scdoc )"

src_prepare() {
	local doc=()
	use doc || doc=(
		-e '/^install:/s/[^ ]\+\.[0-9]//'
		-e '/^\s\+install.*\.[0-9]$/d'
	)

	sed -i Makefile \
		"${doc[@]}" \
		-e '/^CC/d' \
		-e '/^CMD/d' \
		-e '/^PKGNAME/d' \
		-e '/^\(C\|LD\)FLAGS/s/=/+&/' \
		-e '/^LDFLAGS/s/-fuse-ld=[^ ]\+//' \
		-e '/^release:/{
			/O_CFLAGS/s/-O[0-9]\+//;
			/O_LDFLAGS/s/=.*/= $(LDFLAGS)/;
		}' \
	|| die 'sed failed'

	default

	tc-export CC
}

src_compile() {
	local doc=()
	use doc && doc=( 'huxd.1' )

	emake release "${doc[@]}"
}

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
}
