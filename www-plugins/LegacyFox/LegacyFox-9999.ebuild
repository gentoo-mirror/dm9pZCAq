# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib

DESCRIPTION="Monkeypatching Firefox Quantum to run VimFx"
HOMEPAGE="https://git.gir.st/LegacyFox.git"

LICENSE="MPL-2.0"
SLOT="0"

if [[ "${PV}" == 9999 ]]; then
	EGIT_REPO_URI="https://git.gir.st/LegacyFox.git"
	inherit git-r3
else
	SRC_URI="
		https://git.gir.st/${PN}.git/snapshot/refs/tags/v${PV}.tar.gz
			-> ${P}.tar.gz"
	KEYWORDS="amd64 arm64 ppc64 x86"
	S="${WORKDIR}/${PN}-v${PV}"
fi

src_install() {
	local FF_DIR
	FF_DIR="/usr/$(get_libdir)/firefox/"

	dodir "${FF_DIR}"
	emake DESTDIR="${ED}/${FF_DIR#/}" install
}
