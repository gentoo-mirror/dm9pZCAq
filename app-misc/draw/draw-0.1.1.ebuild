# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Draw in your terminal"
HOMEPAGE="https://github.com/maaslalani/draw"
SRC_URI="
	https://github.com/maaslalani/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="amd64"

src_compile() {
	ego build
}

src_install() {
	dobin "${PN}"

	einstalldocs
}
