# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

SRC_URI="
	https://github.com/zhoreeq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

DESCRIPTION="A universal naming system for all IPv6-based mesh networks"
HOMEPAGE="https://github.com/zhoreeq/meshname"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

src_compile() {
	CGO_ENABLED=0 ego build -ldflags "
		-s -w
		-extldflags '-static'
	" "./cmd/${PN}d"
}

src_test() {
	ego test "./pkg/${PN}"/*_test.go
}

src_install() {
	local DOCS=( ./*.md )

	dobin "${PN}d"

	doinitd "contrib/${PN}d.initd"
	systemd_dounit "${PN}d.service"

	einstalldocs
}
