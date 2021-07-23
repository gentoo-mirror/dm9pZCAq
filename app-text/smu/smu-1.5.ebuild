# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Simple markup - markdown like syntax"
HOMEPAGE="https://github.com/Gottox/smu"
SRC_URI="
	https://github.com/Gottox/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

DOCS=( documentation )

src_prepare() {
	sed -i ./config.mk \
		-e '/^CFLAGS/{s/=/+&/;s/-\(g\|O.\)\s\+//g}' \
		-e '/^LDFLAGS/s/=/+&/' \
		-e '/^CC/d' \
	|| die

	sed -i ./Makefile -e '/^all:/s/\s\+options//' || die

	default
}

src_install() {
	emake PREFIX=/usr DESTDIR="${ED}" install

	einstalldocs
}
