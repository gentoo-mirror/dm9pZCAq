# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fcaps linux-info

DESCRIPTION="trace exec() calls system-wide"
HOMEPAGE="https://github.com/leahneukirchen/extrace"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="-pwait"

CONFIG_CHECK="~CONNECTOR ~PROC_EVENTS"

get_all() {
	echo "${PN}" $(usev pwait)
}

src_compile() {
	emake ALL="$(get_all)"
}

src_install() {
	local ALL=( $(get_all) )

	dobin "${ALL[@]}"
	doman "${ALL[@]/%/.1}"
}

pkg_postinst() {
	local ALL=( $(get_all) )

	fcaps cap_net_admin+ep "${ALL[@]/#/usr/bin/}"
}
