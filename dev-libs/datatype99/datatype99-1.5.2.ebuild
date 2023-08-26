# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Algebraic data types for C99"
HOMEPAGE="https://github.com/Hirrolot/datatype99"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux ~x64-macos"

DEPEND=">=dev-lang/metalang99-1.13.2"
RDEPEND="${DEPEND}"

src_install() {
	local DOCS=( README.md examples/ )

	doheader "${PN}.h"

	rm examples/.gitignore || die
	einstalldocs
}
