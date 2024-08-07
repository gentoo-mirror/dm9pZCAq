# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN##zsh-}"

DESCRIPTION="Theme for Zsh that emphasizes speed, flexibility and out-of-the-box experience"
HOMEPAGE="https://github.com/romkatv/powerlevel10k"
SRC_URI="https://github.com/romkatv/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc64 ~x86"

DEPEND="
	app-shells/zsh
	app-shells/gitstatus
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i Makefile -e '/gitstatus/d'

	default
}

src_compile() {
	emake pkg
}

src_install() {
	local DOCS=( {README,font}.md )

	insinto "/usr/share/zsh/site-contrib/${MY_PN}"

	doins -r config/
	doins -r internal/
	doins prompt_*_setup
	doins powerlevel*.zsh-theme{,.zwc}

	dosym ../../../gitstatus \
		"/usr/share/zsh/site-contrib/${MY_PN}/gitstatus"

	einstalldocs
}
