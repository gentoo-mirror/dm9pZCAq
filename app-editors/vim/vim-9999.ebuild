# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Symlinks to use neovim as vim"
HOMEPAGE="https://neovim.io/"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="app-editors/neovim"

src_unpack() {
	mkdir -p "${S}"
}

src_install() {
	dosym nvim /usr/bin/vim
	dosym ../nvim/runtime /usr/share/vim/vimfiles

	exeinto /usr/bin
	doexe "${FILESDIR}/vimdiff"
}
