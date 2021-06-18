# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/jedib0t/go-pretty/v6 v6.0.5"
	"github.com/jedib0t/go-pretty/v6 v6.0.5/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.10"
	"github.com/mattn/go-runewidth v0.0.10/go.mod"
	"github.com/muesli/termenv v0.8.1"
	"github.com/muesli/termenv v0.8.1/go.mod"
	"github.com/pkg/profile v1.2.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.1.0"
	"github.com/rivo/uniseg v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200820211705-5c72a883971a"
	"golang.org/x/crypto v0.0.0-20200820211705-5c72a883971a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/sys v0.0.0-20180816055513-1c9583448a9c/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200918174421-af09f7315aff"
	"golang.org/x/sys v0.0.0-20200918174421-af09f7315aff/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
)

go-module_set_globals
SRC_URI="
	https://github.com/muesli/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

DESCRIPTION="Disk Usage/Free Utility - a better 'df' alternative"
HOMEPAGE="https://github.com/muesli/duf"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc64 ~s390 x86 ~amd64-linux ~x86-linux ~x64-macos ~x64-solaris"

src_compile() {
	go build || die 'go build failed'
}

src_install() {
	local DOCS=( *.md )

	dobin "${PN}"

	einstalldocs
}
