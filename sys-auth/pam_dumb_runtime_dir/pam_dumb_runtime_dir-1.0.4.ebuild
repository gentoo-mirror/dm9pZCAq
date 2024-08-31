# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pam toolchain-funcs

MY_PN="${PN#pam_}"

DESCRIPTION="Creates an XDG_RUNTIME_DIR on login and never removes it"
HOMEPAGE="https://github.com/ifreund/dumb_runtime_dir"
SRC_URI="https://github.com/ifreund/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="0BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i ./Makefile \
		-e '/^CFLAGS/{s/=/+&/;s/-\(g\|O.\)\s\+//g}' \
		-e '/^CC/d' \
	|| die

	default

}

src_compile() {
	tc-env_build emake
}

src_install() {
	einstalldocs

	dopammod "${PN}.so"
}

pkg_postinst() {
	einfo "to use this PAM module, add to '/etc/pam.d/system-login':"
	einfo "'session optional ${PN}.so'"
}
