# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A shell parser, formatter, and interpreter with bash support"
HOMEPAGE="
	https://pkg.go.dev/mvdan.cc/sh/v3
	https://github.com/mvdan/sh
"
SRC_URI="
	https://github.com/mvdan/sh/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"
S="${WORKDIR}/sh-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="+man"

BDEPEND="
	man? ( app-text/scdoc )
"
src_compile() {
	CGO_ENABLED=0 ego build -ldflags="
		-X main.version=${PV}
		-w -s -extldflags '-static'
	" "./cmd/${PN}"

	use man && {
		local man_in="./cmd/${PN}/${PN}.1.scd"
		local man_out="./${PN}.1"

		ebegin "scdoc: '${man_in}' -> '${man_out}'"
		scdoc <"${man_in}" >"${man_out}"
		eend "${?}" 'failed to generate man page' || die "${_}"
	}
}

src_install() {
	dobin "${PN}"

	use man && doman "./${PN}.1"
}
