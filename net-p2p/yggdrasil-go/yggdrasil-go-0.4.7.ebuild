# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module linux-info systemd fcaps

EGO_SUM=(
	"github.com/Arceliar/ironwood v0.0.0-20221115123222-ec61cea2f439"
	"github.com/Arceliar/ironwood v0.0.0-20221115123222-ec61cea2f439/go.mod"
	"github.com/Arceliar/phony v0.0.0-20210209235338-dde1a8dca979"
	"github.com/Arceliar/phony v0.0.0-20210209235338-dde1a8dca979/go.mod"
	"github.com/BurntSushi/xgb v0.0.0-20160522181843-27f122750802/go.mod"
	"github.com/VividCortex/ewma v1.1.1/go.mod"
	"github.com/VividCortex/ewma v1.2.0"
	"github.com/VividCortex/ewma v1.2.0/go.mod"
	"github.com/cheggaaa/pb/v3 v3.0.8"
	"github.com/cheggaaa/pb/v3 v3.0.8/go.mod"
	"github.com/fatih/color v1.10.0/go.mod"
	"github.com/fatih/color v1.12.0"
	"github.com/fatih/color v1.12.0/go.mod"
	"github.com/gologme/log v1.2.0"
	"github.com/gologme/log v1.2.0/go.mod"
	"github.com/hashicorp/go-syslog v1.0.0"
	"github.com/hashicorp/go-syslog v1.0.0/go.mod"
	"github.com/hjson/hjson-go v3.1.0+incompatible"
	"github.com/hjson/hjson-go v3.1.0+incompatible/go.mod"
	"github.com/kardianos/minwinsvc v1.0.2"
	"github.com/kardianos/minwinsvc v1.0.2/go.mod"
	"github.com/lxn/walk v0.0.0-20210112085537-c389da54e794/go.mod"
	"github.com/lxn/win v0.0.0-20210218163916-a377121e959e/go.mod"
	"github.com/mattn/go-colorable v0.1.8"
	"github.com/mattn/go-colorable v0.1.8/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-isatty v0.0.13"
	"github.com/mattn/go-isatty v0.0.13/go.mod"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mattn/go-runewidth v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.13"
	"github.com/mattn/go-runewidth v0.0.13/go.mod"
	"github.com/mitchellh/mapstructure v1.4.1"
	"github.com/mitchellh/mapstructure v1.4.1/go.mod"
	"github.com/olekukonko/tablewriter v0.0.5"
	"github.com/olekukonko/tablewriter v0.0.5/go.mod"
	"github.com/rivo/uniseg v0.1.0/go.mod"
	"github.com/rivo/uniseg v0.2.0"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/vishvananda/netlink v1.1.0"
	"github.com/vishvananda/netlink v1.1.0/go.mod"
	"github.com/vishvananda/netns v0.0.0-20191106174202-0a2b9b5464df/go.mod"
	"github.com/vishvananda/netns v0.0.0-20210104183010-2eb08e3e575f"
	"github.com/vishvananda/netns v0.0.0-20210104183010-2eb08e3e575f/go.mod"
	"github.com/yuin/goldmark v1.4.0/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20190510104115-cbcb75029529/go.mod"
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
	"golang.org/x/crypto v0.0.0-20210421170649-83a5a9bb288b/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.0.0-20221012134737-56aed061732a"
	"golang.org/x/crypto v0.0.0-20221012134737-56aed061732a/go.mod"
	"golang.org/x/exp v0.0.0-20190731235908-ec7cb31e5a56/go.mod"
	"golang.org/x/image v0.0.0-20190227222117-0694c2d4d067/go.mod"
	"golang.org/x/image v0.0.0-20190802002840-cff245a6509b/go.mod"
	"golang.org/x/mobile v0.0.0-20190312151609-d3739f865fa6/go.mod"
	"golang.org/x/mobile v0.0.0-20221110043201-43a038452099"
	"golang.org/x/mobile v0.0.0-20221110043201-43a038452099/go.mod"
	"golang.org/x/mod v0.1.0/go.mod"
	"golang.org/x/mod v0.4.2/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20210805182204-aaa1db679c0d/go.mod"
	"golang.org/x/net v0.0.0-20210927181540-4e4d966f7476/go.mod"
	"golang.org/x/net v0.0.0-20211011170408-caeb26a5c8c0/go.mod"
	"golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.0.0-20221014081412-f15817d10f9b"
	"golang.org/x/net v0.0.0-20221014081412-f15817d10f9b/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.0.0-20220819030929-7fc1605a5dde/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190606203320-7fc4e5ec1444/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200217220822-9197077df867/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20201018230417-eeed37f84f13/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210403161142-5e06dd20ab57/go.mod"
	"golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20210809222454-d867a43fc93e/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.0.0-20211007075335-d3039528d8ac/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220728004956-3c1f35247d10/go.mod"
	"golang.org/x/sys v0.0.0-20221013171732-95e765b1cc43"
	"golang.org/x/sys v0.0.0-20221013171732-95e765b1cc43/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.6/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.3.8-0.20211004125949-5bd84dd9b33b/go.mod"
	"golang.org/x/text v0.3.8"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190312151545-0bb0c0a6e846/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.7/go.mod"
	"golang.org/x/tools v0.1.12"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
	"golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
	"golang.zx2c4.com/wireguard v0.0.0-20211012062646-82d2aa87aa62/go.mod"
	"golang.zx2c4.com/wireguard v0.0.0-20211017052713-f87e87af0d9a"
	"golang.zx2c4.com/wireguard v0.0.0-20211017052713-f87e87af0d9a/go.mod"
	"golang.zx2c4.com/wireguard/windows v0.4.12"
	"golang.zx2c4.com/wireguard/windows v0.4.12/go.mod"
)

go-module_set_globals

DESCRIPTION="An experiment in scalable routing as an encrypted IPv6 overlay network"
HOMEPAGE="https://yggdrasil-network.github.io/"
SRC_URI="
	https://github.com/${PN%%-*}-network/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="LGPL-3 MIT Apache-2.0 BSD ZLIB"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc64 ~riscv ~s390 x86 ~amd64-linux ~x86-linux ~x64-macos ~x64-solaris"
IUSE="+static"

RESTRICT="mirror"

RDEPEND="
	acct-user/${PN%-*}
	acct-group/${PN%-*}
"
BDEPEND=">=dev-lang/go-1.17"

FILECAPS=(
	cap_net_admin,cap_net_raw+eip "usr/bin/${PN%-*}"
)

pkg_setup() {
	linux-info_pkg_setup
	if ! linux_config_exists; then
		eerror "Unable to check your kernel for TUN support"
	else
		CONFIG_CHECK="~TUN"
		ERROR_TUN="Your kernel lacks TUN support."
	fi
}

go_info() {
	set -- go build -v -x "${@:?}"
	einfo "${*}"
	"${@}" || die
}

src_compile() {
	local cmd=''
	local src="github.com/yggdrasil-network/yggdrasil-go/src/version"
	local ldflags="-X ${src}.buildName=${P} -X ${src}.buildVersion=v${PV}"
	use static && {
		export CGO_ENABLED=0
		ldflags+=' -extldflags "-static"'
	}

	for cmd in "${PN%-*}"{,ctl}; do
		go_info -ldflags="${ldflags}" -o "${cmd}" "./cmd/${cmd}"
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
