# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/charmbracelet/bubbletea v0.20.0"
	"github.com/charmbracelet/bubbletea v0.20.0/go.mod"
	"github.com/charmbracelet/lipgloss v0.5.0"
	"github.com/charmbracelet/lipgloss v0.5.0/go.mod"
	"github.com/containerd/console v1.0.3"
	"github.com/containerd/console v1.0.3/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/mattn/go-isatty v0.0.14"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/mattn/go-runewidth v0.0.10/go.mod"
	"github.com/mattn/go-runewidth v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.13"
	"github.com/mattn/go-runewidth v0.0.13/go.mod"
	"github.com/muesli/ansi v0.0.0-20211018074035-2e021307bc4b"
	"github.com/muesli/ansi v0.0.0-20211018074035-2e021307bc4b/go.mod"
	"github.com/muesli/reflow v0.2.1-0.20210115123740-9e1d0d53df68/go.mod"
	"github.com/muesli/reflow v0.3.0"
	"github.com/muesli/reflow v0.3.0/go.mod"
	"github.com/muesli/termenv v0.11.1-0.20220204035834-5ac8409525e0/go.mod"
	"github.com/muesli/termenv v0.11.1-0.20220212125758-44cd13922739"
	"github.com/muesli/termenv v0.11.1-0.20220212125758-44cd13922739/go.mod"
	"github.com/rivo/uniseg v0.1.0/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210124154548-22da62e12c0c/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/term v0.0.0-20210422114643-f5beecf764ed"
	"golang.org/x/term v0.0.0-20210422114643-f5beecf764ed/go.mod"
)

go-module_set_globals

DESCRIPTION="Draw in your terminal"
HOMEPAGE="https://github.com/maaslalani/draw"
SRC_URI="
	${EGO_SUM_SRC_URI}
	https://github.com/maaslalani/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz
"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="amd64"

go_build_info() {
	set -- go build -v -x "${@}"
	einfo "${*}"
	"${@}" || die
}

src_compile() {
	go_build_info
}

src_install() {
	dobin "${PN}"

	einstalldocs
}
