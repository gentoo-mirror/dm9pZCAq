# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module linux-info systemd fcaps

DESCRIPTION="An experiment in scalable routing as an encrypted IPv6 overlay network"
HOMEPAGE="
	https://yggdrasil-network.github.io/
	https://github.com/yggdrasil-network/yggdrasil-go
"
SRC_URI="
	https://github.com/${PN%%-*}-network/${PN}/archive/v${PV/_rc/rc}.tar.gz -> ${P}.tar.gz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
	https://github.com/dm9pZCAq/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="LGPL-3 MIT Apache-2.0 BSD ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~s390 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x64-solaris"

RDEPEND="
	acct-user/${PN%-*}
	acct-group/${PN%-*}
"
BDEPEND=">=dev-lang/go-1.17"

FILECAPS=(
	cap_net_admin,cap_net_raw+eip "usr/bin/${PN%-*}"
)

S="${WORKDIR}/${P/_rc/rc}"

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_config_exists; then
		eerror "Unable to check your kernel for TUN support"
	else
		CONFIG_CHECK="~TUN"
		ERROR_TUN="Your kernel lacks TUN support."
	fi
}

src_compile() {
	local src_version="github.com/yggdrasil-network/yggdrasil-go/src/version"
	local cmd=''
	for cmd in "${PN%-*}"{,ctl}; do
		CGO_ENABLED=0 ego build -ldflags="
			-X ${src_version}.buildName=${P}
			-X ${src_version}.buildVersion=v${PV}
			-extldflags '-static'
		" -o "${cmd}" "./cmd/${cmd}"
	done
}

src_install() {
	dobin yggdrasil{,ctl}

	systemd_dounit "contrib/systemd/${PN%-*}.service"

	doinitd "contrib/openrc/${PN%-*}"

	einstalldocs
}

pkg_postinst() {
	local issue=''

	fcaps_pkg_postinst

	einfo "runit service: https://notabug.org/dm9pZCAq/etcfiles/src/master/sv/${PN%-*}"
	einfo "which can run ${PN%-*} as non-root user"
	einfo "you can see how it's done there to do so for yours init system"
	einfo 'contributing patches here to do so for systemd and openrc are appreciated'
	einfo

	einfo 'also, related upstream issues:'
	for issue in 8{0{2..3},16}; do
		einfo " > https://github.com/yggdrasil-network/yggdrasil-go/issues/${issue}"
	done
}
