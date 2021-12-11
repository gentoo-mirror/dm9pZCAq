# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{2..4} )

inherit lua-single toolchain-funcs

DESCRIPTION="A better hexdump"
HOMEPAGE="https://github.com/kiedtl/huxdemp"
SRC_URI="
	${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
REQUIRED_USE="${LUA_REQUIRED_USE}"


IUSE="+doc"

RDEPEND="${LUA_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	doc? ( app-text/scdoc )
"

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
		-e '/^LDFLAGS/d' \
		-e '/^PKGNAME/d' \
		-e '/^\(C\|LD\)FLAGS/s/=/+&/' \
		-e '/^release:/{
			/O_CFLAGS/s/-O[0-9]\+//;
			/O_LDFLAGS/s/=.*/= $(LDFLAGS)/;
		}' \
	|| die 'sed failed'

	default

	export LDFLAGS="${LDFLAGS} $(lua_get_LIBS)"
	tc-export CC
}

src_compile() {
	local doc=()
	use doc && doc=( 'huxd.1' )

	emake release "${doc[@]}" INCL="-I$(lua_get_include_dir)"
}

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
}
