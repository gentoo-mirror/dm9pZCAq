# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module bash-completion-r1

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/jessevdk/go-assets v0.0.0-20160921144138-4f4301a06e15"
	"github.com/jessevdk/go-assets v0.0.0-20160921144138-4f4301a06e15/go.mod"
	"github.com/jessevdk/go-assets-builder v0.0.0-20130903091706-b8483521738f"
	"github.com/jessevdk/go-assets-builder v0.0.0-20130903091706-b8483521738f/go.mod"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/kr/fs v0.1.0"
	"github.com/kr/fs v0.1.0/go.mod"
	"github.com/mattn/kinako v0.0.0-20170717041458-332c0a7e205a"
	"github.com/mattn/kinako v0.0.0-20170717041458-332c0a7e205a/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pkg/sftp v1.12.0"
	"github.com/pkg/sftp v1.12.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/zeebo/bencode v1.0.0"
	"github.com/zeebo/bencode v1.0.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200820211705-5c72a883971a/go.mod"
	"golang.org/x/crypto v0.0.0-20201016220609-9e8e0b390897"
	"golang.org/x/crypto v0.0.0-20201016220609-9e8e0b390897/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20201017003518-b09fb700fbb7"
	"golang.org/x/sys v0.0.0-20201017003518-b09fb700fbb7/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/leonelquinteros/gotext.v1 v1.3.1"
	"gopkg.in/leonelquinteros/gotext.v1 v1.3.1/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
)

go-module_set_globals

SRC_URI="
	https://github.com/majestrate/XD/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

DESCRIPTION="Anonymous file sharing client"
HOMEPAGE="
	https://xd-torrent.github.io/
	https://github.com/majestrate/XD
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+static webui lokinet"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

go_info() {
	set -- go build -v -x "${@:?}"
	einfo "${*}"
	"${@}" || die
}

src_compile() {
	local ldflags=''
	local tags=(
		$(usev webui)
		$(usev lokinet)
	)
	use static && {
		export CGO_ENABLED=0
		ldflags='-extldflags "-static"'
	}

	use webui && make webui

	go_info -ldflags="${ldflags}" -tags="${tags[*]}" -o "${PN}"
}

src_install() {
	local DOCS=( README.md docs )

	dobin "${PN}"
	dosym "${PN}" "/usr/bin/${PN}-CLI"

	einstalldocs
}
