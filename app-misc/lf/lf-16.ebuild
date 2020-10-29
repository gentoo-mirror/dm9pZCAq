# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/doronbehar/termbox-go v0.0.0-20200711071547-71407e3bfa14"
	"github.com/doronbehar/termbox-go v0.0.0-20200711071547-71407e3bfa14/go.mod"
	"github.com/gdamore/tcell v1.3.0"
	"github.com/gdamore/tcell v1.3.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"gopkg.in/djherbis/times.v1 v1.2.0"
	"gopkg.in/djherbis/times.v1 v1.2.0/go.mod"
)

go-module_set_globals
SRC_URI="https://github.com/gokcehan/lf/archive/r${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"


DESCRIPTION="Terminal file manager"
HOMEPAGE="https://github.com/gokcehan/lf"
IUSE="+static X zsh-completion fish-completion"

KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${PN}-r${PV}"
DOCS="README.md etc/lfrc.example"

src_compile() {
	local my_flags=( -ldflags='-s -w' )
	use static \
		&& my_flags+=( -ldflags='-w -extldflags "-static"' )

	CGO_ENABLED=0 GO111MODULE=on go build "${my_flags[@]}" || die
}

src_install() {
	dobin "${PN}"
	einstalldocs

	insinto /usr/share/${PN}
	doins "etc/${PN}cd.sh"
	doman "${PN}.1"

	use fish-completion && {
		insinto /usr/share/fish/vendor_completions.d
		doins "etc/${PN}.fish"
		insinto /usr/share/fish/vendor_functions.d
		doins "etc/${PN}cd.fish"
	}

	use zsh-completion && {
		insinto /usr/share/zsh/site-functions
		newins "etc/${PN}.zsh" "_${PN}"
	}

	use X && {
		insinto /usr/share/applications
		doins "${PN}.desktop"
	}
}
