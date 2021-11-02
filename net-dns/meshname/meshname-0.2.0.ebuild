# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module systemd

EGO_SUM=(
	"github.com/gologme/log v1.2.0"
	"github.com/gologme/log v1.2.0/go.mod"
	"github.com/miekg/dns v1.1.27"
	"github.com/miekg/dns v1.1.27/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/mod v0.1.1-0.20191105210325-c90efee705ee/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20190923162816-aa69164e4478"
	"golang.org/x/net v0.0.0-20190923162816-aa69164e4478/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190924154521-2837fb4f24fe"
	"golang.org/x/sys v0.0.0-20190924154521-2837fb4f24fe/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/tools v0.0.0-20191216052735-49a3e744a425/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
)

go-module_set_globals
SRC_URI="
	https://github.com/zhoreeq/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

DESCRIPTION="A universal naming system for all IPv6-based mesh networks"
HOMEPAGE="https://github.com/zhoreeq/meshname"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

go_cmd() {
	local myflags=(
		-ldflags '-s -w'
	)
	local cmd="${1:?}" && shift
	local go_cmd=( go "${cmd}" "${myflags[@]}" "${@}" )

	einfo "${go_cmd[*]}"
	CGO_ENABLED=0 "${go_cmd[@]}" || die
}

src_compile() {
	go_cmd build "./cmd/${PN}d"
}

src_test() {
	go_cmd test "./pkg/${PN}"/*_test.go
}

src_install() {
	local DOCS=( *.md )

	dobin "${PN}d"

	doinitd "contrib/${PN}d.initd"
	systemd_dounit "${PN}d.service"

	einstalldocs
}
