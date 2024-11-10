# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module shell-completion

DESCRIPTION="Terminal file manager"
HOMEPAGE="https://github.com/gokcehan/lf"
SRC_URI="
	https://github.com/gokcehan/lf/archive/r${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"
S="${WORKDIR}/${PN}-r${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ppc64 ~s390 x86"

IUSE="+static X"

src_compile() {
	local ldflags="-s -w -X main.gVersion=r${PV}"
	use static && {
		export CGO_ENABLED=0
		ldflags+=' -extldflags "-static"'
	}

	ego build -ldflags="${ldflags}" || die 'go build failed'
}

src_install() {
	local DOCS=( README.md etc/{{color,icon}s,lfrc}.example )

	dobin "${PN}"

	einstalldocs

	doman "${PN}.1"

	# bash & zsh
	insinto "/usr/share/${PN}"
	doins "etc/${PN}cd.sh"

	newbashcomp "etc/${PN}.bash" "${PN}"

	dofishcomp "etc/${PN}.fish"
	dofishcomp "etc/${PN}cd.fish"

	newzshcomp "etc/${PN}.zsh" "_${PN}"

	use X && domenu "${PN}.desktop"
}
