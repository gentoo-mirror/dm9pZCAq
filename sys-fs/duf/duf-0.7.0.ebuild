# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/IGLOU-EU/go-wildcard v1.0.1"
	"github.com/IGLOU-EU/go-wildcard v1.0.1/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/fzipp/gocyclo v0.3.1/go.mod"
	"github.com/jedib0t/go-pretty/v6 v6.2.4"
	"github.com/jedib0t/go-pretty/v6 v6.2.4/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/mattn/go-isatty v0.0.13"
	"github.com/mattn/go-isatty v0.0.13/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.13"
	"github.com/mattn/go-runewidth v0.0.13/go.mod"
	"github.com/muesli/termenv v0.9.0"
	"github.com/muesli/termenv v0.9.0/go.mod"
	"github.com/pkg/profile v1.2.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/stretchr/testify v1.2.2"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"golang.org/x/sys v0.0.0-20180816055513-1c9583448a9c/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210414055047-fe65e336abe0"
	"golang.org/x/sys v0.0.0-20210414055047-fe65e336abe0/go.mod"
	"golang.org/x/term v0.0.0-20210406210042-72f3dc4e9b72"
	"golang.org/x/term v0.0.0-20210406210042-72f3dc4e9b72/go.mod"
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
