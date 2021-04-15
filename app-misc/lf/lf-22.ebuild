# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module bash-completion-r1

EGO_SUM=(
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/encoding v1.0.0/go.mod"
	"github.com/gokcehan/tcell/v2 v2.2.1-0.20210329222449-4dd2d52e83ef"
	"github.com/gokcehan/tcell/v2 v2.2.1-0.20210329222449-4dd2d52e83ef/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.0.3"
	"github.com/lucasb-eyer/go-colorful v1.0.3/go.mod"
	"github.com/mattn/go-runewidth v0.0.10"
	"github.com/mattn/go-runewidth v0.0.10/go.mod"
	"github.com/rivo/uniseg v0.1.0"
	"github.com/rivo/uniseg v0.1.0/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/term v0.0.0-20201210144234-2321bbc49cbf/go.mod"
	"golang.org/x/term v0.0.0-20210220032956-6a3ed077a48d"
	"golang.org/x/term v0.0.0-20210220032956-6a3ed077a48d/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"gopkg.in/djherbis/times.v1 v1.2.0"
	"gopkg.in/djherbis/times.v1 v1.2.0/go.mod"
)

go-module_set_globals
SRC_URI="https://github.com/gokcehan/lf/archive/r${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

DESCRIPTION="Terminal file manager"
HOMEPAGE="https://github.com/gokcehan/lf"
IUSE="+static X bash-completion zsh-completion fish-completion"

KEYWORDS="amd64 ~arm arm64 ppc64 ~s390 x86"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${PN}-r${PV}"
DOCS=( README.md etc/lfrc.example )

src_compile() {
	local ldflags="-s -w -X main.gVersion=r${PV}"
	use static && {
		export CGO_ENABLED=0
		ldflags+=' -extldflags "-static"'
	}

	go build -ldflags="${ldflags}" || die 'go build failed'
}

src_install() {
	dobin "${PN}"

	einstalldocs

	doman "${PN}.1"

	if use bash-completion || use zsh-completion; then
		insinto "/usr/share/${PN}"
		doins "etc/${PN}cd.sh"
	fi

	use bash-completion \
		&& newbashcomp "etc/${PN}.bash" "${PN}"

	use zsh-completion && {
		insinto /usr/share/zsh/site-functions
		newins "etc/${PN}.zsh" "_${PN}"
	}

	use fish-completion && {
		insinto /usr/share/fish/vendor_completions.d
		doins "etc/${PN}.fish"
		insinto /usr/share/fish/vendor_functions.d
		doins "etc/${PN}cd.fish"
	}

	use X && {
		insinto /usr/share/applications
		doins "${PN}.desktop"
	}
}
