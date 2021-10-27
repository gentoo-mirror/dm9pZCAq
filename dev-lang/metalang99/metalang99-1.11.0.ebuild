# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Full-blown preprocessor metaprogramming"
HOMEPAGE="
	https://metalang99.readthedocs.io/en/latest/
	https://github.com/Hirrolot/metalang99
"
SRC_URI="
	https://github.com/Hirrolot/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x64-macos"

src_compile() {
	:
}

src_install() {
	doheader -r include/*

	einstalldocs

	insinto "/usr/share/doc/${P}/examples"
	doins examples/*.c
}
