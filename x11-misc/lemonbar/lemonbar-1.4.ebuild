# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A featherweight, lemon-scented, bar based on xcb"
HOMEPAGE="https://github.com/LemonBoy/bar"
SRC_URI="${HOMEPAGE}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc"

DEPEND="x11-libs/libxcb"
RDEPEND="${DEPEND}"
BDEPEND="doc? ( dev-lang/perl )"

S="${WORKDIR}/${P##lemon}"

src_compile() {
	emake all $(usev doc)
}

src_install() {
	dobin "${PN}"

	use doc && doman "${PN}.1"
}
