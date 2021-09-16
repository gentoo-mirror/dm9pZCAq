# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="run a command at a particular time"
HOMEPAGE="https://github.com/leahneukirchen/snooze"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="amd64 ~x86"

src_install() {
	dobin "${PN}"
	doman "${PN}.1"
}
