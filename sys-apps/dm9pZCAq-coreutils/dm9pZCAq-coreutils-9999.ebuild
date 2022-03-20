# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="GNU compatible suckless coreutils"
HOMEPAGE="https://notabug.org/dm9pZCAq/dm9pZCAq-coreutils"
EGIT_REPO_URI="https://notabug.org/dm9pZCAq/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="-path"

BDEPEND=">=dev-lang/metalang99-1.8"

BASEDIR="/opt/${PN}"

src_install() {
	emake PREFIX='' DESTDIR="${ED}/${BASEDIR#/}" install

	local prefix=60
	use path && prefix=40
	# original PATH seted from 50baselayout
	# if we want to use this coreutils insetad of GNU coreutils
	# we need to set our path first

	local var_name="${PN^^}"
	printf '%s="%s"\n' \
		"${var_name/-/_}" "${BASEDIR}" \
		PATH "${BASEDIR}/bin" \
		ROOTPATH "${BASEDIR}/bin" \
	| newenvd - "${prefix}${PN}"
}
